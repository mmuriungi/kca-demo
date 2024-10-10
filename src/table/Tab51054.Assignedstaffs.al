table 51054 "Assigned staffs"
{
    Caption = 'Assigned staffs';
    DataClassification = ToBeClassified;

    fields
    {
        field(6; no; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(1; "Staff Number"; Code[40])
        {
            Caption = 'Staff Number';
            TableRelation = if ("Consultant Type" = filter(Vendor)) Vendor."No." else
            "HRM-Employee C"."No.";
            trigger OnValidate()
            var
                hr: Record "HRM-Employee C";
                fullname: Text[100];
                Vendor: Record Vendor;
            begin
                if "Consultant Type" = "Consultant Type"::Vendor then begin
                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.", "Staff Number");
                    if Vendor.FindFirst then begin
                        rec."staff name" := Vendor.Name;
                        rec."staff email" := Vendor."E-Mail";
                        rec."phone Number" := Vendor."Phone No.";
                    end;
                end;
                hr.Reset;
                hr.SetRange(hr."No.", "Staff Number");
                IF hr.FindFirst then begin
                    // Concatenate First Name, Middle Name, and Last Name with spaces
                    FullName := hr."First Name";

                    if not rec.IsNullOrEmpty(hr."Middle Name") then
                        FullName := FullName + ' ' + hr."Middle Name";

                    if not rec.IsNullOrEmpty(hr."Last Name") then
                        FullName := FullName + ' ' + hr."Last Name";

                    rec."staff name" := FullName;

                    rec."staff email" := hr."Company E-Mail";
                    rec."phone Number" := hr."Cellular Phone Number";

                    // No need to call rec.Modify() in OnValidate trigger
                end;

            end;

        }

        field(2; "staff name"; Text[50])
        {
            Caption = 'staff name';
        }
        field(3; "staff email"; Code[60])
        {
            Caption = 'staff email';
        }
        field(4; "phone Number"; Text[56])
        {
            Caption = 'phone Number';
        }
        field(5; comment; Text[60])
        {
            Caption = 'comment';
        }
        //Consultant type
        field(7; "Consultant Type"; Option)
        {
            OptionMembers = " ",Staff,Vendor;
        }
    }
    keys
    {
        key(PK; no, "Staff Number")
        {
            Clustered = true;
        }
    }
    procedure IsNullOrEmpty(Value: Text): Boolean;
    begin
        exit(Value = '');
    end;
}
