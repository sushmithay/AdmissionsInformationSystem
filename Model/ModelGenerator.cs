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
						SocialSecurityNumber = "234-11-2334",
						FirstName = "Phani",
						MiddleName = "Bonda",
						LastName = "Ndra",
						Address = "Albmarle Rd. Charlotte NC, 28262",
						InState = "Yes",
						Email = "phani@uncc.edu",
						PhoneNumber = "(342) 342-1243",
						GPA = 4.0f,
						SAT = 1600
					},
					new Student { 
						SocialSecurityNumber = "342-41-2332",
						FirstName = "Daniel",
						MiddleName = "",
						LastName = "Scroggins",
						Address = "John Krik Dr. Atlanta GA, 28275",
						InState = "Yes",
						Email = "daniel@uncc.edu",
						PhoneNumber = "(342) 342-1423",
						GPA = 4.0f,
						SAT = 1234
					},
					new Student { 
						SocialSecurityNumber = "324-23-412",
						FirstName = "Roxolana",
						MiddleName = "",
						LastName = "Buckle",
						Address = "Wt Harris Blvd Charlotte NC, 28262",
						InState = "Yes",
						Email = "roxo@uncc.edu",
						PhoneNumber = "(123) 324-1234",
						GPA = 4.0f,
						SAT = 4312
					},
					new Student { 
						SocialSecurityNumber = "122-34-322",
						FirstName = "Virginia",
						MiddleName = "",
						LastName = "Kern",
						Address = "JW Clay Road NC, 28262",
						InState = "Yes",
						Email = "kern@uncc.edu",
						PhoneNumber = "(123) 123-1432",
						GPA = 4.0f,
						SAT = 4231
					},
					new Student { 
						SocialSecurityNumber = "124-34-232",
						FirstName = "Swetha",
						MiddleName = "Metireddy",
						LastName = "Keerthi",
						Address = "Milton Road Los Angles CA 38262",
						InState = "Yes",
						Email = "swetha@uncc.edu",
						PhoneNumber = "(123) 132-1231",
						GPA = 4.0f,
						SAT = 1243
					},
					new Student { 
						SocialSecurityNumber = "432-12-3412",
						FirstName = "Sushmita",
						MiddleName = "",
						LastName = "Yalla",
						Address = "Sharone Emity Dr Cary NC 24262",
						InState = "Yes",
						Email = "sylla@uncc.edu",
						PhoneNumber = "(321) 132-1234",
						GPA = 4.0f,
						SAT = 1432
					},
					new Student { 
						SocialSecurityNumber = "324-14-2312",
						FirstName = "Krishna",
						MiddleName = "",
						LastName = "Chaitanya",
						Address = "Clories Road Clevland OH 38943",
						InState = "Yes",
						Email = "phani@uncc.edu",
						PhoneNumber = "(123) 123-1423",
						GPA = 4.0f,
						SAT = 1432
					}
				}
			);
		}

		public static FakeContext<Parameter> BuildFakeParameters()
		{
			return new FakeContext<Parameter>(new List<Parameter> {
				new Parameter {
					GPAThreshold = 3.0M,
					GPAWeight = .3M,					   
					SATThreshold = 1000,
					SATWeight = .6M,
					OutOfStateWeight = .5M
				}
			});
		}

		public static FakeContext<CollegeLife> BuildFakeCollegeLife()
		{
			return new FakeContext<CollegeLife>(new List<CollegeLife> {
				new CollegeLife {
					Name = "Campus Events",
					Description = @"The Campus Events website is your resource for hundreds of activities and events held at UNC Charlotte throughout the year. Search this online calendar by date or event categories such as speakers, arts, entertainment, recreation, career, and more. Promote your own campus department or student organization's activities by submitting your campus events online."
				},
				new CollegeLife {
					Name = "Student Involvement",
					Description = @"Getting involved at UNC Charlotte means discovering new interests, learning skills, and making contributions to your campus community. It’s also about having fun and meeting friends, whether you are planning events and activities, participating in leadership or diversity programs, or joining one of over 325 UNC Charlotte student organizations."
				},
				new CollegeLife {
					Name = "Recreation",
					Description = @"UNC Charlotte has plenty of opportunities for you to get active. We offer a variety of sport clubs, intramurals, fitness programs, and special events ranging from competitive to recreational. Our facilities include a fitness center, aerobics studio, indoor climbing wall, swimming pool, and recreational courts free of charge for students. Our Fitness Program provides services and fitness classes for all interests and skill levels year round."
				},
				new CollegeLife {
					Name = "Health",
					Description = @"We provide affordable, confidential, on-campus health care for students through the Student Health Center. Our Counseling Center offers free and confidential counseling for students dealing with emotional, relationship, or personal concerns as well as workshops and consultations. A bevy of services are available to help you get healthy and stay healthy while you're in school."
				},
				new CollegeLife {
					Name = "Housing",
					Description = @"You don’t have to trade comfort for the convenience of on-campus living. The list of housing options for freshmen and upper-classmen keeps growing, and so does the list of on-campus housing amenities. Find out whether living on campus is right for you."
				}
			});
		}

		public static FakeContext<DegreeProgram> BuildFakeDegreePrograms()
		{
			return new FakeContext<DegreeProgram>(new List<DegreeProgram> {
				new DegreeProgram {
					Name = "Bioinformatics",
					Description = "CS now offers a path through the Computer Science M.S. degree program by taking only evening classes (5 pm or later). At least twelve courses will be offered in the evening on a three-year rotation schedule such that it is possible to satisfy the program requirements and graduate within three years by taking a suitable selection of ten of these evening classes. This program should be of particular interest to working professionals."
				},
				new DegreeProgram {
					Name = "Computer Science",
					Description = "CS now offers a path through the Computer Science M.S. degree program by taking only evening classes (5 pm or later). At least twelve courses will be offered in the evening on a three-year rotation schedule such that it is possible to satisfy the program requirements and graduate within three years by taking a suitable selection of ten of these evening classes. This program should be of particular interest to working professionals."
				},
				new DegreeProgram {
					Name = "Information Technology",
					Description = "The Software and Information Systems Department is a pioneer in Information Technology research and education emphasizing on designing and deploying integrated, secure, reliable, and easy-to-use IT solutions. We offer a wide selection of courses in Information Technology, Information Security and Privacy, Human Computer Interaction, Web Development, and Software Engineering. Our security and Privacy program is recognized by the National Security Agency as a National Center of Academic Excellence in Information Assurance Education and Research."
				}
			});
		}
	}
}
