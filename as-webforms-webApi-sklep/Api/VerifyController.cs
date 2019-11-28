using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace as_webforms_webApi_sklep.Api
{
    public class VerifyController : ApiController
    {
        // GET: api/Verify
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Verify/5
        public string Get(int id)
        {
            string url = "https://translate.google.pl/#en|pl|";
            Redirect(url);
            return "https://translate.google.pl/#en|pl|";
        }

        // POST: api/Verify
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Verify/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Verify/5
        public void Delete(int id)
        {
        }
    }
}
