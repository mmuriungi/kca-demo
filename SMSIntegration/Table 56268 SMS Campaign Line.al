table 56268 "SMS Campaign Line"
{
    Caption = 'SMS Campaign Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = "SMS Campaign Header";
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Recipient Type"; Enum "SMS Recipient Type")
        {
            Caption = 'Recipient Type';
            DataClassification = ToBeClassified;
        }
        field(4; "Recipient No."; Code[20])
        {
            Caption = 'Recipient No.';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                GetRecipientInfo();
            end;

            trigger OnLookup()
            begin
                LookupRecipient();
            end;
        }
        field(5; "Recipient Name"; Text[100])
        {
            Caption = 'Recipient Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = ToBeClassified;
            
            trigger OnValidate()
            begin
                ValidatePhoneNumber();
            end;
        }
        field(7; "Status"; Enum "SMS Line Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Sent DateTime"; DateTime)
        {
            Caption = 'Sent DateTime';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Response Code"; Text[50])
        {
            Caption = 'Response Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Request ID"; Text[50])
        {
            Caption = 'Request ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Selected"; Boolean)
        {
            Caption = 'Selected';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Campaign No.", "Line No.")
        {
            Clustered = true;
        }
        key(RecipientKey; "Recipient Type", "Recipient No.")
        {
        }
        key(StatusKey; Status)
        {
        }
    }

    trigger OnInsert()
    begin
        if "Line No." = 0 then
            "Line No." := GetNextLineNo();
        Status := Status::Pending;
    end;

    local procedure GetNextLineNo(): Integer
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", "Campaign No.");
        if SMSCampaignLine.FindLast() then
            exit(SMSCampaignLine."Line No." + 10000);
        exit(10000);
    end;

    local procedure GetRecipientInfo()
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        KUCCPSImports: Record "KUCCPS Imports";
    begin
        case "Recipient Type" of
            "Recipient Type"::Customer:
                begin
                    if Customer.Get("Recipient No.") then begin
                        "Recipient Name" := Customer.Name;
                        "Phone Number" := Customer."Phone No.";
                    end;
                end;
            "Recipient Type"::Vendor:
                begin
                    if Vendor.Get("Recipient No.") then begin
                        "Recipient Name" := Vendor.Name;
                        "Phone Number" := Vendor."Phone No.";
                    end;
                end;
            "Recipient Type"::KUCCPS:
                begin
                    KUCCPSImports.SetRange(admin, "Recipient No.");
                    if KUCCPSImports.FindFirst() then begin
                        "Recipient Name" := KUCCPSImports.Names;
                        "Phone Number" := KUCCPSImports.Phone;
                    end;
                end;
        end;
    end;

    local procedure LookupRecipient()
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        KUCCPSImports: Record "KUCCPS Imports";
        CustomerList: Page "Customer List";
        VendorList: Page "Vendor List";
        KUCCPSList: Page "KUCCPS Imports";
    begin
        case "Recipient Type" of
            "Recipient Type"::Customer:
                begin
                    CustomerList.LookupMode(true);
                    if CustomerList.RunModal() = Action::LookupOK then begin
                        CustomerList.GetRecord(Customer);
                        Validate("Recipient No.", Customer."No.");
                    end;
                end;
            "Recipient Type"::Vendor:
                begin
                    VendorList.LookupMode(true);
                    if VendorList.RunModal() = Action::LookupOK then begin
                        VendorList.GetRecord(Vendor);
                        Validate("Recipient No.", Vendor."No.");
                    end;
                end;
            "Recipient Type"::KUCCPS:
                begin
                    KUCCPSList.LookupMode(true);
                    if KUCCPSList.RunModal() = Action::LookupOK then begin
                        KUCCPSList.GetRecord(KUCCPSImports);
                        Validate("Recipient No.", KUCCPSImports.Admin);
                    end;
                end;
        end;
    end;

    local procedure ValidatePhoneNumber()
    var
        PhoneRegex: Text;
    begin
        if "Phone Number" = '' then
            exit;
            
        PhoneRegex := '^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{4,6}$';
        
        "Phone Number" := DelChr("Phone Number", '=', ' ');
        
        if StrLen("Phone Number") < 10 then
            Error('Phone number must be at least 10 digits');
    end;
}