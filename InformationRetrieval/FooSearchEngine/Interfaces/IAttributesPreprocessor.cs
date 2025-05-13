using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Interfaces
{
    interface IAttributesPreprocessor
    {
        /// <summary>
        /// Filter attributes for a given global and document vectors
        /// based on information gain
        /// </summary>
        /// <param name="globalVector"></param>
        /// <param name="documents"></param>
        public void FilterAttributes(List<string> globalVector, List<Document> documents);
    }
}
