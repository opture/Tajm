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

namespace Tajm.Controllers
{
    public class WorkTasksController : Controller
    {
        private TajmContext db = new TajmContext();

        // GET: WorkTasks
        public async Task<ActionResult> Index()
        {
            return View(await db.WorkTasks.ToListAsync());
        }

        // GET: WorkTasks/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            WorkTask workTask = await db.WorkTasks.FindAsync(id);
            if (workTask == null)
            {
                return HttpNotFound();
            }
            return View(workTask);
        }

        // GET: WorkTasks/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: WorkTasks/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Name,Price")] WorkTask workTask)
        {
            if (ModelState.IsValid)
            {
                db.WorkTasks.Add(workTask);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(workTask);
        }

        // GET: WorkTasks/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            WorkTask workTask = await db.WorkTasks.FindAsync(id);
            if (workTask == null)
            {
                return HttpNotFound();
            }
            return View(workTask);
        }

        // POST: WorkTasks/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "ID,Name,Price")] WorkTask workTask)
        {
            if (ModelState.IsValid)
            {
                db.Entry(workTask).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(workTask);
        }

        // GET: WorkTasks/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            WorkTask workTask = await db.WorkTasks.FindAsync(id);
            if (workTask == null)
            {
                return HttpNotFound();
            }
            return View(workTask);
        }

        // POST: WorkTasks/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            WorkTask workTask = await db.WorkTasks.FindAsync(id);
            db.WorkTasks.Remove(workTask);
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
    }
}
