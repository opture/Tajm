using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Tajm.Startup))]
namespace Tajm
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
