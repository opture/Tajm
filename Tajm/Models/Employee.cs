using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace Tajm.Models
{
    public class Employee
    {
        [Key]
        public int Id { get; set; }
        public string userId { get; set;  }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        [JsonIgnore]
        public virtual ICollection<TaskTime> WorkTasks { get; set; }
        [NotMapped]
        public string FullName
        {
            get
            {
                return string.Format("{0} {1}", FirstName, LastName);
            }
        }
    }
}
