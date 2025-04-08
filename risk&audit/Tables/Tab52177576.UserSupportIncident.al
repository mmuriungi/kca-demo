table 50129 "User Support Incident"
{

    fields
    {
        field(1; "Incident Reference"; Code[20])
        {

            trigger OnValidate()
            begin

                if (Type = Type::AUDIT) then begin
                    if "Incident Reference" <> xRec."Incident Reference" then
                        NoSeriesMgt.TestManual(AuditSetup."Incident Reporting Nos.");
                end;
                if (Type = Type::ICT) then begin
                    if "Incident Reference" <> xRec."Incident Reference" then
                        NoSeriesMgt.TestManual(ICTSetup."incidence Nos");
                end;
                if (Type = Type::PROPERTY) then begin
                    if "Incident Reference" <> xRec."Incident Reference" then
                        NoSeriesMgt.TestManual(ICTSetup."Property Issue  Nos");
                end;
            end;
        }
        field(2; "Incident Description"; Text[250])
        {
        }
        field(3; "Incident Date"; Date)
        {
        }
        field(4; "Incident Status"; Option)
        {
            OptionCaption = 'Unresolved,Resolved';
            OptionMembers = Unresolved,Resolved;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; "Action taken"; Text[250])
        {

            trigger OnValidate()
            begin
                "Action By" := UserId;
            end;
        }
        field(7; "Action Date"; Date)
        {
        }
        field(8; User; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(9; "System Support Email Address"; Text[80])
        {
        }
        field(10; "User email Address"; Text[80])
        {
        }
        field(11; Type; Option)
        {
            OptionCaption = 'ICT,ADM,REGISTRY,KEYS,AUDIT,PROPERTY';
            OptionMembers = ICT,ADM,REGISTRY,"KEYS",AUDIT,PROPERTY;
        }
        field(12; "File No"; Code[30])
        {
        }
        field(13; "Incident Time"; Time)
        {
        }
        field(14; "Action Time"; Time)
        {
        }
        field(15; "Employee No"; Code[20])
        {
            TableRelation = "HRM-Employee C";
            trigger OnValidate()
            begin
                IF Employee.GET("Employee No") THEN BEGIN
                    "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "User email Address" := Employee."Company E-Mail";
                END;
            end;
        }
        field(16; "Employee Name"; Text[100])
        {
        }
        field(17; Sent; Boolean)
        {
        }
        field(18; "Incidence Resolved"; Boolean)
        {
        }
        field(19; "Work place Controller"; Code[10])
        {
            TableRelation = "HRM-Employee C";
        }
        field(20; "Work place Controller Name"; Text[100])
        {
        }
        field(21; "Incidence Location"; Code[10])
        {
        }
        field(22; "Incidence Location Name"; Text[100])
        {
        }
        field(23; "Incidence Outcome"; Option)
        {
            OptionCaption = '  ,Dangerous,Serious bodily injury,Work caused illness,Serious electrical incident,Dangerous electrical event,MajorAccident under the OSHA Act';
            OptionMembers = "  ",Dangerous,"Serious bodily injury","Work caused illness","Serious electrical incident","Dangerous electrical event","MajorAccident under the OSHA Act";
        }
        field(24; "Incident Outcome"; Option)
        {
            OptionCaption = '  ,Yes,No';
            OptionMembers = "  ",Yes,No;
        }
        field(25; "Remarks HR"; Text[250])
        {
        }
        field(26; "User Informed?"; Boolean)
        {
        }
        field(27; Priority; Option)
        {
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ",Low,Medium,High;
        }
        field(28; "Expected Action Date"; Date)
        {
        }
        field(29; "User Remarks"; Text[250])
        {
        }
        field(30; "Incident Rating"; Option)
        {
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
        }
        field(31; "Incident Type"; Option)
        {
            OptionCaption = 'Hardware,Software';
            OptionMembers = Hardware,Software;
        }
        field(32; Status; Option)
        {
            OptionCaption = 'Open,Pending,Assigned,Solved,Escalated,Closed';
            OptionMembers = Open,Pending,Assigned,Solved,Escalated,Closed;
            trigger OnValidate()
            begin


            end;
        }
        field(33; "Escalate To"; Code[50])
        {
            TableRelation = if ("Escalation option" = const(Internal)) Employee;
            trigger Onvalidate()
            var
                Emp: Record "HRM-Employee C";
            begin
                Emp.Reset();
                Emp.SetRange("No.", "Escalate To");
                if Emp.FindFirst() then begin
                    "Escalate To Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Escalation email Address" := Emp."Company E-Mail";
                    UserSetup.Reset;
                    UserSetup.SetRange("Employee No.", Employee."No.");
                    if UserSetup.Find('-') then begin
                        "Escalation User ID" := UserSetup."User ID";
                    end;
                end;
            end;
        }
        field(34; "Ecalation Date"; Date)
        {
            Caption = 'Escalation Date';
        }
        field(35; "Screen Shot"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(36; "Action By"; Code[30])
        {
        }
        field(37; "Delegated To"; Code[50])
        {
            Caption = 'Assigned to';
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C";
            trigger Onvalidate()
            var
                Employee: Record "HRM-Employee C";
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Delegated To");
                if Employee.Find('-') then begin
                    "Delegated To Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    //Get UserId
                    UserSetup.Reset;
                    UserSetup.SetRange("Employee No.", Employee."No.");
                    if UserSetup.Find('-') then begin
                        "Delegated User ID" := UserSetup."User ID";
                    end;
                end;
            end;
        }
        field(38; "Delegated To Name"; Text[100])
        {
            Caption = 'Assigned to name';
            DataClassification = ToBeClassified;
        }
        field(39; "Delegated User ID"; Code[50])
        {
            Caption = 'Assigned to user ID';
            DataClassification = ToBeClassified;
        }
        field(40; "Incident Cause"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(42; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(43; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //ShowDimensions;
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }

        field(44; "Linked Risk"; Code[50])
        {
            TableRelation = "Risk Header";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                RiskHeader: Record "Risk Header";
            begin
                IF RiskHeader.GET(Rec."Linked Risk") THEN BEGIN
                    RiskHeader.CalcFields("Risk Description");
                    "Linked Risk Description" := RiskHeader."Risk Description";
                END;
            end;

        }
        field(45; "Rejection reason"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Linked Risk Description"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Escalation option"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Internal,External;
            OptionCaption = ' ,Internal,External';
        }
        field(48; "Escalation email Address"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Escalate To Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Escalation Time"; time)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Escalation User ID"; Code[50])
        {
            Caption = 'Escalated to user ID';
            DataClassification = ToBeClassified;
        }
        field(52; "Assign Asset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Comment on Property"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Employee Confirm Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Employee Confirm Receipt Date" := Today;
            end;
        }
        field(55; "Employee Confirm Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Manager Confirm Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Manager Confirm Receipt Date" := Today;
                "Manager Confirm Receipt ID" := UserId;
            end;
        }
        field(57; "Manager Confirm Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Employee Confirm Return"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Employee Confirm Return Date" := Today;
            end;
        }
        field(59; "Employee Confirm Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "ICT Confirm Return"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "ICT Confirm Return Date" := Today;
                "ICT Confirm Return ID" := UserId;
            end;
        }
        field(61; "ICT Confirm Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "ICT Confirm Return ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Manager Confirm Receipt ID"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Asset Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Receipt,Return;
            OptionCaption = ' ,Receipt,Return';
        }
        field(65; "Asset Associated With Incident"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset";
            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if FA.Get("Asset Associated With Incident") then
                    "Asset Name2" := FA.Description;
            end;
        }
        field(66; "Asset Name"; Code[20])
        {
            ObsoleteState = removed;
            DataClassification = ToBeClassified;
        }
        field(67; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Asset Name2"; Text[100])
        {
            Caption = 'Asset Name';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Incident Reference")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Incident Reference", "Incident Description")
        {
        }
    }

    trigger OnInsert()
    begin
        if not ICTSetup.Get then begin
            ICTSetup.Init();
            ICTSetup.Insert();
        end;

        if not AuditSetup.Get then begin
            AuditSetup.Init();
            AuditSetup.Insert();
        end;

        case Type of
            Type::AUDIT:
                begin
                    AuditSetup.TestField("Incident Reporting Nos.");
                    NoSeriesMgt.InitSeries(AuditSetup."Incident Reporting Nos.", xRec."No. Series", Today, "Incident Reference", "No. Series");
                end;
            Type::ICT:
                begin
                    NoSeriesMgt.InitSeries(ICTSetup."Incidence Nos", xRec."No. Series", 0D, "Incident Reference", "No. Series");
                end;
            Type::PROPERTY:
                begin
                    ICTSetup.TestField("Property Issue  Nos");
                    NoSeriesMgt.InitSeries(ICTSetup."Property Issue  Nos", xRec."No. Series", Today, "Incident Reference", "No. Series");
                end;
        end;

        User := UserId;
        ;
        if UserSetup.Get(UserId) then begin
            if Employee.Get(UserSetup."Employee No.") then begin
                "Employee No" := Employee."No.";
                "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                VALIDATE("Employee No");
                "User email Address" := Employee."Company E-Mail";
                "Incident Date" := Today;
                "Incident Time" := Time;
                "Incident Status" := "Incident Status"::Unresolved;
                case Type of
                    Type::AUDIT:
                        begin
                            "Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                            Validate("Shortcut Dimension 1 Code");
                            "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                            Validate("Shortcut Dimension 2 Code");
                        end;
                end;
            end;
        end;
    end;

    var
        ICTSetup: Record "ICT Setup";
        CommentLine: Record "Comment Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CompanyInformation: Record "Company Information";
        UserSetup: Record "User Setup";
        Employee: Record "HRM-Employee C";
        emp2: Record "HRM-Employee C";
        DimMgt: Codeunit DimensionManagement;
        AuditSetup: Record "Audit Setup";

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

