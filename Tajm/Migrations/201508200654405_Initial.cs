namespace Tajm.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.WorkTask", "Name", c => c.String());
            AddColumn("dbo.WorkTask", "Price", c => c.Int(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.WorkTask", "Price");
            DropColumn("dbo.WorkTask", "Name");
        }
    }
}
