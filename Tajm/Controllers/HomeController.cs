using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Tajm.DAL;
using Tajm.Models;
using System.Data.Entity.Infrastructure;
namespace Tajm.Controllers
{
    public class HomeController : Controller
    {
        private TajmContext db = new TajmContext();
        public ActionResult Index()
        {

            var customerQuery = from c in db.Customers orderby c.Name select c;
            ViewBag.CustomerId = new SelectList(customerQuery, "Id", "Name", null);
            var employeeQuery = from e in db.Employees orderby e.FirstName select e;
            ViewBag.EmployeeId = new SelectList(employeeQuery, "Id", "FullName", null);
            var taskQuery = from wt in db.WorkTasks orderby wt.Name select wt;
            ViewBag.TaskId = new SelectList(taskQuery, "Id", "DisplayFormat", null);

            ViewBag.latestTasks = db.TaskTimes.Where(_tt => !(_tt.End == null)).OrderByDescending(_tt => _tt.End);
            TaskTime homeModel = new TaskTime();


            homeModel.Start = DateTime.Now;
            return View(homeModel);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}