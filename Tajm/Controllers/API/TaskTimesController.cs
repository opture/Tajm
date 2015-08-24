using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Web.OData;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using Tajm.DAL;
using Tajm.Models;


namespace Tajm.Controllers.API
{
    public class TaskTimesController : ApiController
    {
        private TajmContext db = new TajmContext();

        // GET: api/ApiTaskTimes
        [EnableQuery]
        public IQueryable<TaskTime> GetTaskTimes()
        {

            /* dynamic result = db.TaskTimes.Where(_tt => (_tt.EmployeeId.Equals(EmployeeId) || !EmployeeId.HasValue))
                   .Select(_tt => new { CustomerName = _tt.Customer.Name, _tt.Description, _tt.Employee.FirstName, _tt.ID, _tt.Start, _tt.End, TaskName = _tt.Task.Name });
                   */
            return db.TaskTimes.AsQueryable();
        }

        // GET: api/ApiTaskTimes/5
        [ResponseType(typeof(TaskTime))]
        public async Task<IHttpActionResult> GetTaskTime(int id)
        {
            TaskTime taskTime = await db.TaskTimes.FindAsync(id);
            if (taskTime == null)
            {
                return NotFound();
            }

            return Ok(taskTime);
        }

        // PUT: api/ApiTaskTimes/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutTaskTime(int id, TaskTime taskTime)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != taskTime.Id)
            {
                return BadRequest();
            }

            db.Entry(taskTime).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TaskTimeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/ApiTaskTimes
        [ResponseType(typeof(TaskTime))]
        public async Task<IHttpActionResult> PostTaskTime( TaskTime taskTime)
        {
            taskTime.Customer = null;
            taskTime.Employee = null;
            taskTime.Task = null;
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.TaskTimes.Add(taskTime);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = taskTime.Id }, taskTime);
        }

        // DELETE: api/ApiTaskTimes/5
        [ResponseType(typeof(TaskTime))]
        public async Task<IHttpActionResult> DeleteTaskTime(int id)
        {
            TaskTime taskTime = await db.TaskTimes.FindAsync(id);
            if (taskTime == null)
            {
                return NotFound();
            }

            db.TaskTimes.Remove(taskTime);
            await db.SaveChangesAsync();

            return Ok(taskTime);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool TaskTimeExists(int id)
        {
            return db.TaskTimes.Count(e => e.Id == id) > 0;
        }
    }
}