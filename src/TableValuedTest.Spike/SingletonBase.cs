using System;

namespace TableValuedTest.Spike
{
    public abstract class SingletonBase<T>
    {
        private static readonly object m_lock = new object();
        private static T m_singletonInstance;

        public delegate T CreateInstanceDelegate();

        protected static CreateInstanceDelegate m_CreateInstanceDelegate;

        protected static T SingletonInstance
        {
            get
            {
                //has the instance already been instantiated?
                if (m_singletonInstance == null)
                {
                    //create lock
                    lock (m_lock)
                    {
                        //check again to make m_singletinInstance is still null
                        if (m_singletonInstance == null)
                        {
                            if (m_CreateInstanceDelegate == null)
                                throw new Exception("Cannot create singleton as the CreateInstanceDelegate is not set");
                            m_singletonInstance = m_CreateInstanceDelegate();
                        }
                    }
                }
                return m_singletonInstance;
            }
        }
    }

    public class Singleton<T> : SingletonBase<T> where T : new()
    {
        static Singleton()
        {
            m_CreateInstanceDelegate = DefaultCreateInstance;
        }

        private static T DefaultCreateInstance()
        {
            return new T();
        }

        //make the instance accessible to the public
        public static T Instance
        {
            get
            {
                return SingletonInstance;
            }
        }
    }
}