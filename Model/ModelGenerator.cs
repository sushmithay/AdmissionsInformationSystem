using AdmissionsInformationSystem.Context;
using System.Collections.Generic;

namespace AdmissionsInformationSystem.Model
{
	public static class ModelGenerator
	{
		public static FakeStudentContext BuildFakes()
		{
			return new FakeStudentContext(
				new List<Student>() {
					new Student() { Name = "test1" },
					new Student() { Name = "test2" },
					new Student() { Name = "test3" },
					new Student() { Name = "test4" }
				}
			);
		}
	}
}
