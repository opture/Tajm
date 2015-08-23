using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
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
    public class WorkTasksController : ApiController
    {
        private TajmContext db = new TajmContext();

        // GET: api/WorkTasks
        public IQueryable<WorkTask> GetWorkTasks()
        {
            return db.WorkTasks;
        }

        // GET: api/WorkTasks/5
        [ResponseType(typeof(WorkTask))]
        public async Task<IHttpActionResult> GetWorkTask(int id)
        {
            WorkTask workTask = await db.WorkTasks.FindAsync(id);
            if (workTask == null)
            {
                return NotFound();
            }

            return Ok(workTask);
        }

        // PUT: api/WorkTasks/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutWorkTask(int id, WorkTask workTask)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != workTask.Id)
            {
                return BadRequest();
            }

            db.Entry(workTask).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WorkTaskExists(id))
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

        // POST: api/WorkTasks
        [ResponseType(typeof(WorkTask))]
        public async Task<IHttpActionResult> PostWorkTask(WorkTask workTask)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.WorkTasks.Add(workTask);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = workTask.Id }, workTask);
        }

        // DELETE: api/WorkTasks/5
        [ResponseType(typeof(WorkTask))]
        public async Task<IHttpActionResult> DeleteWorkTask(int id)
        {
            WorkTask workTask = await db.WorkTasks.FindAsync(id);
            if (workTask == null)
            {
                return NotFound();
            }

            db.WorkTasks.Remove(workTask);
            await db.SaveChangesAsync();

            return Ok(workTask);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool WorkTaskExists(int id)
        {
            return db.WorkTasks.Count(e => e.Id == id) > 0;
        }
    }
}