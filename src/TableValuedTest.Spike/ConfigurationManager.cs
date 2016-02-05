using System;
using System.Configuration;

namespace TableValuedTest.Spike
{
    public partial class ConfigurationManager
    {
        public static ConnectionStringsManager ConnectionStrings
        {
            get
            {
                return ConnectionStringsManager.Instance;
            }
        }
    }

    public class ConnectionStringsManager
    : Singleton<ConnectionStringsManager>
    {
        public ConnectionStringsManager() { }

        public string GetConnectionString(string name)
        {
            var strConnectionString = GetConnectionString(name, null);
            if (strConnectionString == null) throw new Exception("The Connection String [" + name + "] does not exist");
            return strConnectionString;
        }

        public string GetConnectionString(string name, string Default)
        {
            var settings = System.Configuration.ConfigurationManager.ConnectionStrings[name];
            if (settings == null) return Default;
            return settings.ConnectionString;
        }

        public bool Exists(string name)
        {
            return GetConnectionString(name, null) != null;
        }

        public string this[string name]
        {
            get { return GetConnectionString(name); }
        }

        public string this[string name, string Default]
        {
            get { return GetConnectionString(name, Default); }
        }
    }
}