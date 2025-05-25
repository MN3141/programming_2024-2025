using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace FooSearchEngine.Classes
{
    class XMLExtractor: AttributesExtractor
    {
        public string[] XMLFilesPaths { get; set; }

        public XMLExtractor(string[] xMLFilesPaths)
        {
            XMLFilesPaths = xMLFilesPaths;
        }
        public XMLExtractor(string filePath)
        {
            XMLFilesPaths = Directory.GetFiles(filePath);
        }
        public override void ParseData()
        {
            List<Document> parsedDocuments = new List<Document>();
            SetStopWords(stopWordsFile);
            for (int i = 0; i < XMLFilesPaths.Length; i++)
            {
                Document document = new Document(XMLFilesPaths[i]);
                this.ParseXMLFile(document);
                parsedDocuments.Add(document);
            }
            this._documents = parsedDocuments;
        }
        private void ParseXMLFile(Document doc)
        {
            using XmlReader reader = XmlReader.Create(doc.FileName);
            while (reader.Read())
            {
                if (reader.NodeType == XmlNodeType.Element && reader.Name == "title")
                {
                    reader.Read(); // Move to the text node (inside <title>)
                    doc.Title = reader.Value;
                }
                else if (reader.NodeType == XmlNodeType.Element && reader.Name == "text")
                {
                    while (reader.Read())
                    {
                        // Check for the <p> tags inside <text>
                        if (reader.NodeType == XmlNodeType.Element && reader.Name == "p")
                        {
                            string paragraph = reader.ReadElementContentAsString();
                            List<string> rawWords = paragraph.ToLower().Split(" ").ToList();
                            FilterList(rawWords, doc);

                        }
                        else if (reader.NodeType == XmlNodeType.EndElement && reader.Name == "text")
                            break; // We are only interested in the document title and it's text;

                    }
                }
                else if (reader.NodeType == XmlNodeType.Element && reader.Name == "codes" && reader.GetAttribute("class") == "bip:topics:1.0")
                {
                    // Get the document label/class/topic
                    while (reader.Read())
                    {
                        if (reader.NodeType == XmlNodeType.Element && reader.Name == "code")
                        {
                            string topic = reader.GetAttribute("code");
                            doc.Topic = topic;
                            break;
                        }
                    }
                }
            }
        }
    }
}
