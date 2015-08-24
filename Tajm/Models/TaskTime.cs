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
    public class TaskTime
    {
        [Key]
        public int Id { get; set; }
        public virtual int CustomerId { get; set; }
        [JsonIgnore]
        public virtual Customer Customer { get; set; }
        public virtual int EmployeeId { get; set; }
        [JsonIgnore]
        public virtual Employee Employee { get; set; }
        public virtual int TaskId { get; set; }
        [JsonIgnore]
        public virtual WorkTask Task { get; set; }
        public string Description { get; set; }
        public DateTime Start { get; set; }
        public DateTime? End { get; set; }
        public bool Invoiced { get; set; }

    }
}
