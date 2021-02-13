using Microsoft.AspNetCore.Hosting;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Helpers {

    public class PathProvider {

        IWebHostEnvironment environment;

        public PathProvider(IWebHostEnvironment environment) { this.environment = environment; }

        public String MapPath (String fileName, String folders) {
            //El nombre tiene que ser igual al del servidor
            String folder = folders.ToString().ToLower();
            String path = Path.Combine(this.environment.WebRootPath, folder, fileName);
            return path;
        }

        public List<String> FindFiles (String reg, String folder) {
            List<String> imgs = new List<string>();
            var imagesPath = Path.Combine(this.environment.WebRootPath, folder);
            DirectoryInfo dir = new DirectoryInfo(imagesPath);
            FileInfo[] files = dir.GetFiles();
            foreach(FileInfo file in files) {
                if(Path.GetFileNameWithoutExtension(file.Name) == reg) {
                    imgs.Add(folder + @"/" + file.Name);
                }else if(Regex.IsMatch(file.Name, reg + @"[A-Z]+")) {
                    imgs.Add(folder + @"/" + file.Name);
                }
            }
            return imgs;
        }
    }
}
