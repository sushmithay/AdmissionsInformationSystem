using AdmissionsInformationSystem.Context;
using System.Collections.Generic;

namespace AdmissionsInformationSystem.Model
{
	public static class ModelGenerator
	{
		public static FakeContext<Student> BuildFakeStudents()
		{
			return new FakeContext<Student>(
				new List<Student> {
					new Student { 
						SocialSecurityNumber = "111-11-1111",
						Name = "Student A",
						Address = "123 Yellow Ln.",
						Email = "abc@xyz.com",
						PhoneNumber = "(555) 555-5555",
						GPA = 4.0f,
						SAT = 1600
					},
					new Student { 
						SocialSecurityNumber = "111-11-1111",
						Name = "Student B",
						Address = "123 Yellow Ln.",
						Email = "abc@xyz.com",
						PhoneNumber = "(555) 555-5555",
						GPA = 4.0f,
						SAT = 1600
					},
					new Student { 
						SocialSecurityNumber = "111-11-1111",
						Name = "Student C",
						Address = "123 Yellow Ln.",
						Email = "abc@xyz.com",
						PhoneNumber = "(555) 555-5555",
						GPA = 4.0f,
						SAT = 1600
					}
				}
			);
		}

		public static FakeContext<Parameter> BuildFakeParameters()
		{
			return new FakeContext<Parameter>(new List<Parameter> {
				new Parameter {
					GPAThreshold = 3.0f,
					GPAWeight = 10,					   
					SATThreshold = 1200,
					SATWeight = 10,
					PreferInState = true
				}
			});
		}
	}
}
