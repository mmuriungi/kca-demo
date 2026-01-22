xmlport 52179050 "Foundation Donor Import"
{
    Caption = 'Foundation Donor Import';
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
            tableelement(Donor; "Foundation Donor")
            {
                XmlName = 'Donor';

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

                trigger OnBeforeInsertRecord()
                var
                    ExistingDonor: Record "Foundation Donor";
                begin
                    if Donor."No." = '' then
                        Donor."No." := GetNextDonorNo();

                    if ExistingDonor.Get(Donor."No.") then begin
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

    local procedure GetNextDonorNo(): Code[20]
    var
        Donor: Record "Foundation Donor";
        NextNo: Integer;
    begin
        Donor.SetCurrentKey("No.");
        if Donor.FindLast() then
            NextNo := 1
        else
            NextNo := 1;

        repeat
            NextNo += 1;
        until not Donor.Get('DON' + Format(NextNo));

        exit('DON' + Format(NextNo));
    end;

    procedure GetImportStatistics(var Processed: Integer; var Inserted: Integer; var Skipped: Integer)
    begin
        Processed := ImportedRecordsProcessed;
        Inserted := ImportedRecordsInserted;
        Skipped := ImportedRecordsSkipped;
    end;
}