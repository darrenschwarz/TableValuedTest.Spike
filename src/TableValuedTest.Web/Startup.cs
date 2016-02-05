using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TableValuedTest.Web.Startup))]
namespace TableValuedTest.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
