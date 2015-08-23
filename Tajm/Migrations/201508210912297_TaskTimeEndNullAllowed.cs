namespace Tajm.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class TaskTimeEndNullAllowed : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.TaskTime", "End", c => c.DateTime());
        }
        
        public override void Down()
        {
            AlterColumn("dbo.TaskTime", "End", c => c.DateTime(nullable: false));
        }
    }
}
