namespace Tajm.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class TaskTimeIds : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.TaskTime", "Customer_ID", "dbo.Customer");
            DropForeignKey("dbo.TaskTime", "Employee_ID", "dbo.Employee");
            DropForeignKey("dbo.TaskTime", "Task_ID", "dbo.WorkTask");
            DropIndex("dbo.TaskTime", new[] { "Customer_ID" });
            DropIndex("dbo.TaskTime", new[] { "Employee_ID" });
            DropIndex("dbo.TaskTime", new[] { "Task_ID" });
            RenameColumn(table: "dbo.TaskTime", name: "Customer_ID", newName: "CustomerId");
            RenameColumn(table: "dbo.TaskTime", name: "Employee_ID", newName: "EmployeeId");
            RenameColumn(table: "dbo.TaskTime", name: "Task_ID", newName: "TaskId");
            AlterColumn("dbo.TaskTime", "CustomerId", c => c.Int(nullable: false));
            AlterColumn("dbo.TaskTime", "EmployeeId", c => c.Int(nullable: false));
            AlterColumn("dbo.TaskTime", "TaskId", c => c.Int(nullable: false));
            CreateIndex("dbo.TaskTime", "CustomerId");
            CreateIndex("dbo.TaskTime", "EmployeeId");
            CreateIndex("dbo.TaskTime", "TaskId");
            AddForeignKey("dbo.TaskTime", "CustomerId", "dbo.Customer", "ID", cascadeDelete: true);
            AddForeignKey("dbo.TaskTime", "EmployeeId", "dbo.Employee", "ID", cascadeDelete: true);
            AddForeignKey("dbo.TaskTime", "TaskId", "dbo.WorkTask", "ID", cascadeDelete: true);
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.TaskTime", "TaskId", "dbo.WorkTask");
            DropForeignKey("dbo.TaskTime", "EmployeeId", "dbo.Employee");
            DropForeignKey("dbo.TaskTime", "CustomerId", "dbo.Customer");
            DropIndex("dbo.TaskTime", new[] { "TaskId" });
            DropIndex("dbo.TaskTime", new[] { "EmployeeId" });
            DropIndex("dbo.TaskTime", new[] { "CustomerId" });
            AlterColumn("dbo.TaskTime", "TaskId", c => c.Int());
            AlterColumn("dbo.TaskTime", "EmployeeId", c => c.Int());
            AlterColumn("dbo.TaskTime", "CustomerId", c => c.Int());
            RenameColumn(table: "dbo.TaskTime", name: "TaskId", newName: "Task_ID");
            RenameColumn(table: "dbo.TaskTime", name: "EmployeeId", newName: "Employee_ID");
            RenameColumn(table: "dbo.TaskTime", name: "CustomerId", newName: "Customer_ID");
            CreateIndex("dbo.TaskTime", "Task_ID");
            CreateIndex("dbo.TaskTime", "Employee_ID");
            CreateIndex("dbo.TaskTime", "Customer_ID");
            AddForeignKey("dbo.TaskTime", "Task_ID", "dbo.WorkTask", "ID");
            AddForeignKey("dbo.TaskTime", "Employee_ID", "dbo.Employee", "ID");
            AddForeignKey("dbo.TaskTime", "Customer_ID", "dbo.Customer", "ID");
        }
    }
}
