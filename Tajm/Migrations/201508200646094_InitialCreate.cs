namespace Tajm.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Customer",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Address = c.String(),
                        Zip = c.String(),
                        City = c.String(),
                        Phone = c.String(),
                        Email = c.String(),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.TaskTime",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Description = c.String(),
                        Start = c.DateTime(nullable: false),
                        End = c.DateTime(nullable: false),
                        Customer_ID = c.Int(),
                        Employee_ID = c.Int(),
                        Task_ID = c.Int(),
                    })
                .PrimaryKey(t => t.ID)
                .ForeignKey("dbo.Customer", t => t.Customer_ID)
                .ForeignKey("dbo.Employee", t => t.Employee_ID)
                .ForeignKey("dbo.WorkTask", t => t.Task_ID)
                .Index(t => t.Customer_ID)
                .Index(t => t.Employee_ID)
                .Index(t => t.Task_ID);
            
            CreateTable(
                "dbo.Employee",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        FirstName = c.String(),
                        LastName = c.String(),
                    })
                .PrimaryKey(t => t.ID);
            
            CreateTable(
                "dbo.WorkTask",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                    })
                .PrimaryKey(t => t.ID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.TaskTime", "Task_ID", "dbo.WorkTask");
            DropForeignKey("dbo.TaskTime", "Employee_ID", "dbo.Employee");
            DropForeignKey("dbo.TaskTime", "Customer_ID", "dbo.Customer");
            DropIndex("dbo.TaskTime", new[] { "Task_ID" });
            DropIndex("dbo.TaskTime", new[] { "Employee_ID" });
            DropIndex("dbo.TaskTime", new[] { "Customer_ID" });
            DropTable("dbo.WorkTask");
            DropTable("dbo.Employee");
            DropTable("dbo.TaskTime");
            DropTable("dbo.Customer");
        }
    }
}
