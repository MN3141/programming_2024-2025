using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FooSearchEngine.Classes
{
    class TXTExtractor: AttributesExtractor
    {
        List<string> query;

        public TXTExtractor(List<string> query)
        {
            this.query = query;
        }

        public override void ParseData()
        {
            Document queryDoc = new Document();
            FilterList(query, queryDoc);

        }
    }
}
