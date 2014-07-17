namespace AdmissionsInformationSystem.Model
{
	public class Parameter
	{
		public float GPAThreshold { get; set; }
		public int SATThreshold { get; set; }
		public float GPAWeight { get; set; }
		public float SATWeight { get; set; }
		public bool PreferInState { get; set; }
		public string InquiryResponse { get; set; }
		public string ApplicationResponse { get; set; }
	}
}
