using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Tajm.DAL;
using Tajm.Models;
using System.Data.Entity.Infrastructure;

namespace Tajm.Controllers
{
    public class TaskTimesController : Controller
    {
        private TajmContext db = new TajmContext();

        // GET: TaskTimes
        public async Task<ActionResult> Index()
        {
            return View(await db.TaskTimes.ToListAsync());
        }

        // GET: TaskTimes/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TaskTime taskTime = await db.TaskTimes.FindAsync(id);
            if (taskTime == null)
            {
                return HttpNotFound();
            }
            return View(taskTime);
        }

        // GET: TaskTimes/Create
        public ActionResult Create()
        {
            var customerQuery = from c in db.Customers orderby c.Name select c;
            ViewBag.CustomerId = new SelectList(customerQuery, "Id", "Name", null);
            var employeeQuery = from e in db.Employees orderby e.FirstName select e;
            ViewBag.EmployeeId = new SelectList(employeeQuery, "Id", "FirstName", null);
            var taskQuery = from wt in db.WorkTasks orderby wt.Name select wt;
            ViewBag.TaskId = new SelectList(taskQuery, "Id", "Name", null);
            

            return View();
        }

        // POST: TaskTimes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "ID,Description,Start,End, CustomerId, EmployeeId, TaskId")] TaskTime taskTime)
        {
            if (ModelState.IsValid)
            {
                db.TaskTimes.Add(taskTime);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(taskTime);
        }

        // GET: TaskTimes/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TaskTime taskTime = await db.TaskTimes.FindAsync(id);
            if (taskTime == null)
            {
                return HttpNotFound();
            }
            return View(taskTime);
        }

        // POST: TaskTimes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "ID,Description,Start,End")] TaskTime taskTime)
        {
            if (ModelState.IsValid)
            {
                db.Entry(taskTime).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(taskTime);
        }

        // GET: TaskTimes/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TaskTime taskTime = await db.TaskTimes.FindAsync(id);
            if (taskTime == null)
            {
                return HttpNotFound();
            }
            return View(taskTime);
        }

        // POST: TaskTimes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            TaskTime taskTime = await db.TaskTimes.FindAsync(id);
            db.TaskTimes.Remove(taskTime);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
        private void PopulateDropdowns() {
            //Customers dropdown
            var customerQuery = from c in db.Customers orderby c.Name select c;
            ViewBag.CustomerId = new SelectList(customerQuery, "Id", "Name", null);

            //Employees dropdown
            var employeeQuery = from e in db.Employees orderby e.FirstName select e;
            ViewBag.EmployeeId = new SelectList(employeeQuery, "Id", "FirstName", null);

            //Task dropdown
            var taskQuery = from wt in db.WorkTasks orderby wt.Name select wt;
            ViewBag.TaskId = new SelectList(taskQuery, "Id", "Name", null);
        }
    }
}
