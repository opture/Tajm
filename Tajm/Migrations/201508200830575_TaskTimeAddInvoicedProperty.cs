namespace Tajm.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class TaskTimeAddInvoicedProperty : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.TaskTime", "Invoiced", c => c.Boolean(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.TaskTime", "Invoiced");
        }
    }
}
