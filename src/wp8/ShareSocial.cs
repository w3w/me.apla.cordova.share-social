using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Phone.Tasks;
using WPCordovaClassLib.Cordova;
using WPCordovaClassLib.Cordova.Commands;
using WPCordovaClassLib.Cordova.JSON;

namespace Cordova.Extension.Commands
{
    class ShareSocial : BaseCommand
    {
        public void share(string options)
        {
            string[] jsOptions = JsonHelper.Deserialize<string[]>(options);
            string url = jsOptions[2];
            string heading = jsOptions[0];

            ShareLinkTask shareLinkTask = new ShareLinkTask();

            shareLinkTask.Title = heading;
            shareLinkTask.LinkUri = new Uri(url, UriKind.Absolute);

            shareLinkTask.Show();
        }
    }
}
