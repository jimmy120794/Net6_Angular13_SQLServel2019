using System.ComponentModel.DataAnnotations;

namespace InspectionAPI
{
    
    public class Inspection
    {
        public int Id { get; set; }

        [StringLength(20)]
        public string Status { get; set; } = string.Empty;

        [Required]
        [StringLength(1000)]
        public string Comments { get; set; } = null!;

        public int InspectionTypeId { get; set; }

        public InspectionType? InspectionType { get; set;}


    }
}
