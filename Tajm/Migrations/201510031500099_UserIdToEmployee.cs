namespace Tajm.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UserIdToEmployee : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Employee", "userId", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Employee", "userId");
        }
    }
}
