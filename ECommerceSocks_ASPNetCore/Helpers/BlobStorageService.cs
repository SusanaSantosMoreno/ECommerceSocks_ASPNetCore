using Azure.Storage.Blobs;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Helpers {
    public class BlobStorageService {

        IConfiguration configuration;

        public BlobStorageService (IConfiguration conf) {
            this.configuration = conf;
        }

        public async void cargarBlobs () {

        }
    }
}
