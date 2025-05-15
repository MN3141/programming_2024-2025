using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Classes
{
    /// <summary>
    /// Store the number of appearances and missings based on document labels for
    /// a given attribute.
    /// </summary>
    class AttributeCounter
    {
        public Dictionary<string, int> Present { get; set; } = new Dictionary<string, int>();
        public Dictionary<string, int> Missing { get; set; } = new Dictionary<string, int>();

    }
}
