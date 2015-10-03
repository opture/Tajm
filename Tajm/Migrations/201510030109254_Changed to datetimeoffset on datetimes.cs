namespace Tajm.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Changedtodatetimeoffsetondatetimes : DbMigration
    {
        public override void Up()
        {
            AlterColumn("dbo.TaskTime", "Start", c => c.DateTimeOffset(nullable: false, precision: 7));
            AlterColumn("dbo.TaskTime", "End", c => c.DateTimeOffset(precision: 7));
        }
        
        public override void Down()
        {
            AlterColumn("dbo.TaskTime", "End", c => c.DateTime());
            AlterColumn("dbo.TaskTime", "Start", c => c.DateTime(nullable: false));
        }
    }
}
