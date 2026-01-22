xmlport 52179000 "CRM Customer Import"
{
    Caption = 'CRM Customer Import';
    Direction = Import;
    Format = VariableText;
    FieldDelimiter = '<TAB>';
    FieldSeparator = '<TAB>';
    RecordSeparator = '<NewLine>';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Customer; "CRM Customer")
            {
                XmlName = 'Customer';

                fieldelement(No; Customer."No.")
                {
                }
                fieldelement(CustomerType; Customer."Customer Type")
                {
                }
                fieldelement(FirstName; Customer."First Name")
                {
                }
                fieldelement(MiddleName; Customer."Middle Name")
                {
                }
                fieldelement(LastName; Customer."Last Name")
                {
                }
                fieldelement(Email; Customer."Email")
                {
                }
                fieldelement(PhoneNo; Customer."Phone No.")
                {
                }
                fieldelement(MobilePhoneNo; Customer."Mobile Phone No.")
                {
                }
                fieldelement(Address; Customer."Address")
                {
                }
                fieldelement(Address2; Customer."Address 2")
                {
                }
                fieldelement(City; Customer."City")
                {
                }
                fieldelement(County; Customer."County")
                {
                }
                fieldelement(CountryRegionCode; Customer."Country/Region Code")
                {
                }
                fieldelement(PostCode; Customer."Post Code")
                {
                }
                fieldelement(DateOfBirth; Customer."Date of Birth")
                {
                }
                fieldelement(Gender; Customer."Gender")
                {
                }
                fieldelement(MaritalStatus; Customer."Marital Status")
                {
                }
                fieldelement(Nationality; Customer."Nationality")
                {
                }
                fieldelement(IDPassportNo; Customer."ID/Passport No.")
                {
                }
                fieldelement(StudentNo; Customer."Student No.")
                {
                }
                fieldelement(EmployeeNo; Customer."Employee No.")
                {
                }
                fieldelement(AlumniNo; Customer."Alumni No.")
                {
                }
                fieldelement(ParentGuardianName; Customer."Parent/Guardian Name")
                {
                }
                fieldelement(ParentGuardianPhone; Customer."Parent/Guardian Phone")
                {
                }
                fieldelement(AcademicProgram; Customer."Academic Program")
                {
                }
                fieldelement(AcademicYear; Customer."Academic Year")
                {
                }
                fieldelement(GraduationDate; Customer."Graduation Date")
                {
                }
                fieldelement(EnrollmentDate; Customer."Enrollment Date")
                {
                }
                fieldelement(LeadSource; Customer."Lead Source")
                {
                }
                fieldelement(LeadStatus; Customer."Lead Status")
                {
                }
                fieldelement(LeadScore; Customer."Lead Score")
                {
                }
                fieldelement(PreferredContactMethod; Customer."Preferred Contact Method")
                {
                }
                fieldelement(LanguageCode; Customer."Language Code")
                {
                }
                fieldelement(SegmentationCode; Customer."Segmentation Code")
                {
                }
                fieldelement(EngagementScore; Customer."Engagement Score")
                {
                }
                fieldelement(VIP; Customer."VIP")
                {
                }
                fieldelement(DoNotContact; Customer."Do Not Contact")
                {
                }
                fieldelement(EmailOptIn; Customer."Email Opt-In")
                {
                }
                fieldelement(SMSOptIn; Customer."SMS Opt-In")
                {
                }
                fieldelement(PhoneOptIn; Customer."Phone Opt-In")
                {
                }
                fieldelement(SocialMediaHandle; Customer."Social Media Handle")
                {
                }
                fieldelement(LinkedInProfile; Customer."LinkedIn Profile")
                {
                }
                fieldelement(FacebookProfile; Customer."Facebook Profile")
                {
                }
                fieldelement(TwitterHandle; Customer."Twitter Handle")
                {
                }
                fieldelement(InstagramHandle; Customer."Instagram Handle")
                {
                }
                fieldelement(CompanyName; Customer."Company Name")
                {
                }
                fieldelement(JobTitle; Customer."Job Title")
                {
                }
                fieldelement(Industry; Customer."Industry")
                {
                }
                fieldelement(AnnualIncome; Customer."Annual Income")
                {
                }
                fieldelement(Notes; Customer."Notes")
                {
                }
                fieldelement(Tags; Customer."Tags")
                {
                }
                fieldelement(Inactive; Customer."Inactive")
                {
                }
                fieldelement(GDPRConsentDate; Customer."GDPR Consent Date")
                {
                }
                fieldelement(DataRetentionDate; Customer."Data Retention Date")
                {
                }
                fieldelement(PreferredLanguage; Customer."Preferred Language")
                {
                }
                fieldelement(TimeZone; Customer."Time Zone")
                {
                }
                fieldelement(SatisfactionScore; Customer."Satisfaction Score")
                {
                }
                fieldelement(AgeGroup; Customer."Age Group")
                {
                }

                trigger OnBeforeInsertRecord()
                var
                    ExistingCustomer: Record "CRM Customer";
                begin
                    if Customer."No." = '' then
                        Customer."No." := GetNextCustomerNo();

                    if ExistingCustomer.Get(Customer."No.") then begin
                        ImportedRecordsSkipped += 1;
                        currXMLport.Skip();
                    end else
                        ImportedRecordsProcessed += 1;
                end;

                trigger OnAfterInsertRecord()
                begin
                    ImportedRecordsInserted += 1;
                end;
            }
        }
    }

    var
        ImportedRecordsProcessed: Integer;
        ImportedRecordsInserted: Integer;
        ImportedRecordsSkipped: Integer;

    local procedure GetNextCustomerNo(): Code[20]
    var
        Customer: Record "CRM Customer";
        NextNo: Integer;
    begin
        Customer.SetCurrentKey("No.");
        if Customer.FindLast() then
            NextNo := 1
        else
            NextNo := 1;

        repeat
            NextNo += 1;
        until not Customer.Get(Format(NextNo));

        exit(Format(NextNo));
    end;

    procedure GetImportStatistics(var Processed: Integer; var Inserted: Integer; var Skipped: Integer)
    begin
        Processed := ImportedRecordsProcessed;
        Inserted := ImportedRecordsInserted;
        Skipped := ImportedRecordsSkipped;
    end;
}