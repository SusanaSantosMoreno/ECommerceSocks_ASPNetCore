using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Helpers {
    public class ToolkitService {

        public static byte[] IntToByteArray(int num) {
            byte[] intBytes = BitConverter.GetBytes(num);
            if (BitConverter.IsLittleEndian) {
                Array.Reverse(intBytes);
            }
            byte[] result = intBytes;
            return result;
        }

        public static byte[] ObjectToByteArray(object obj) {
            if (obj == null) {
                return null;
            }
            BinaryFormatter bf = new BinaryFormatter();
            using (MemoryStream ms = new MemoryStream()) {
                bf.Serialize(ms, obj);
                return ms.ToArray();
            }
        }

        public static String SerializeJsonObject (object obj) {
            return JsonConvert.SerializeObject(obj);
        }

        public static T DeserializeJsonObject<T> (String jsonObj) {
            return JsonConvert.DeserializeObject<T>(jsonObj);
        }

        public static string GenerarToken () {
            Random rnd = new Random();
            string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

            return new string(Enumerable.Repeat(chars, 16).Select(s => s[rnd.Next(s.Length)]).ToArray());
        }
    }
}
