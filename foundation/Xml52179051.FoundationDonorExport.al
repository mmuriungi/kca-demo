xmlport 52179051 "Foundation Donor Export"
{
    Caption = 'Foundation Donor Export';
    Direction = Export;
    Format = VariableText;
    FieldDelimiter = '<TAB>';
    FieldSeparator = '<TAB>';
    RecordSeparator = '<NewLine>';
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Donor; "Foundation Donor")
            {
                XmlName = 'Donor';
                RequestFilterFields = "Donor Type", "Recognition Level", "Blocked", "Created Date";

                fieldelement(No; Donor."No.")
                {
                }
                fieldelement(DonorType; Donor."Donor Type")
                {
                }
                fieldelement(Name; Donor."Name")
                {
                }
                fieldelement(Name2; Donor."Name 2")
                {
                }
                fieldelement(ContactPerson; Donor."Contact Person")
                {
                }
                fieldelement(Email; Donor."Email")
                {
                }
                fieldelement(PhoneNo; Donor."Phone No.")
                {
                }
                fieldelement(MobilePhoneNo; Donor."Mobile Phone No.")
                {
                }
                fieldelement(Address; Donor."Address")
                {
                }
                fieldelement(Address2; Donor."Address 2")
                {
                }
                fieldelement(City; Donor."City")
                {
                }
                fieldelement(PostCode; Donor."Post Code")
                {
                }
                fieldelement(CountryRegionCode; Donor."Country/Region Code")
                {
                }
                fieldelement(AlumniID; Donor."Alumni ID")
                {
                }
                fieldelement(GraduationYear; Donor."Graduation Year")
                {
                }
                fieldelement(Faculty; Donor."Faculty")
                {
                }
                fieldelement(Department; Donor."Department")
                {
                }
                fieldelement(RecognitionLevel; Donor."Recognition Level")
                {
                }
                fieldelement(PreferredContactMethod; Donor."Preferred Contact Method")
                {
                }
                fieldelement(AnonymousDonor; Donor."Anonymous Donor")
                {
                }
                fieldelement(TaxExemptNo; Donor."Tax Exempt No.")
                {
                }
                fieldelement(DonorCategory; Donor."Donor Category")
                {
                }
                fieldelement(MarketingOptIn; Donor."Marketing Opt-In")
                {
                }
                fieldelement(NewsletterSubscription; Donor."Newsletter Subscription")
                {
                }
                fieldelement(Blocked; Donor."Blocked")
                {
                }
                fieldelement(Notes; Donor."Notes")
                {
                }
                fieldelement(CreatedDate; Donor."Created Date")
                {
                }
                fieldelement(TotalDonations; Donor."Total Donations")
                {
                }
                fieldelement(LastDonationDate; Donor."Last Donation Date")
                {
                }
                fieldelement(NumberOfDonations; Donor."No. of Donations")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ExportedRecordsCount += 1;
                end;
            }
        }
    }

    var
        ExportedRecordsCount: Integer;

    procedure GetExportStatistics(): Integer
    begin
        exit(ExportedRecordsCount);
    end;
}