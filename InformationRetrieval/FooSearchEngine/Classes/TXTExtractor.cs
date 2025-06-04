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

        public TXTExtractor(string query)
        {
            this.query = query.Split(" ").ToList();
        }

        public override void ParseData()
        {
            Document queryDoc = new Document();
            FilterList(query,queryDoc);
            _documents.Add(queryDoc);
        }
    }
}
