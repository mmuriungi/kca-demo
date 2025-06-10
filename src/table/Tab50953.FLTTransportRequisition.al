table 50953 "FLT-Transport Requisition"
{
    DrillDownPageID = "FLT-Transport Req. List";
    LookupPageID = "FLT-Transport Req. List";

    fields
    {
        field(1; "Transport Requisition No"; Code[20])
        {
        }
        field(2; Commencement; Text[30])
        {
        }
        field(3; Destination; Text[2048])
        {
        }
        field(467; "Vehicle  Registartion Number"; code[50])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No." where(Inactive = const(false));
            trigger OnValidate()
            var
                VehicleHeader: Record "FLT-Vehicle Header";
            begin
                VehicleHeader.Reset();
                VehicleHeader.SetRange("Registration No.", "Vehicle  Registartion Number");
                if VehicleHeader.FindFirst() then
                    Rec."Veh Capacity" := VehicleHeader.Capacity;

            end;

        }
        field(678; "Veh Capacity"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Vehicle Allocated"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
            Caption = 'Vehicle I Allocated';
            trigger OnValidate()
            var
                usr: Record Users;
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
                usr.Reset();
                usr.SetRange("User Name", "Transport Officer");
                if usr.Find('-') then
                    "Transport Officer Name" := usr."Full Name";
                "Transport  Approval Date" := WorkDate();
                "Transport Approval Time" := Time;

            end;
        }
        field(34; "Transport  Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Transport Approval Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Driver Allocated"; Code[20])
        {

            TableRelation = "FLT-Driver".Driver where(Active = const(false));

            trigger OnValidate()
            var
                FLT: record "FLT-Driver";
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
                IF FLT.GET("Driver Name") THEN begin
                    "Driver Name" := (FLT."Driver Name");
                    Designation := FLT.Designation;
                    DriverContact := FLT."Driver Contact";
                end;

            end;

            //TableRelation = "FLT-Driver";
            // trigger OnValidate()
            // begin
            //     if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
            //     if HrEmployee.Get("Driver Allocated") then begin
            //         "Driver Name" := HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
            //     end;
            //     "Authorized  By" := UserId;

            //     userset.Reset;
            //     userset.SetRange(userset."User ID", UserId);
            //     if userset.Find('-') then begin
            //         Emp.Reset;
            //         //Emp.SetRange(Emp."No.",userset."Employee No.");
            //         if Emp.Find('-') then begin
            //             "TO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            //             "Driver Name" := Emp."Phone Number";
            //             ;
            //         end;
            //     end;
            //     Modify;
            // end;
        }
        field(6; "Requested By"; Code[50])
        {
        }
        field(7; "Date of Request"; Date)
        {
        }
        field(56; DriverContact; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Vehicle Allocated by"; Code[20])
        {
        }
        field(9; "Opening Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,"Pending Approval",Approved,closed;

            trigger OnValidate()
            begin
                if Status = Status::Approved then begin
                    fltman2.Reset;
                    fltman2.SetRange(fltman2."Finance Approver", true);
                    if fltman2.Find('-') then begin
                        "Checked By" := fltman2.UserID;
                        "Checked Designation" := 'FIN OFFICER';
                    end;
                end;
            end;
        }
        field(13; "Date of Trip"; Date)
        {
        }
        field(14; "Purpose of Trip"; Text[250])
        {
        }
        field(60; "No. Series"; Code[20])
        {
            Description = 'Stores the number series in the database';
        }
        field(61; Comments; Text[250])
        {
        }
        field(62; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(2));
            trigger OnValidate()
            var
                ApprovalSetup: Record "Transport Approval Setup";
                usr: Record User;
                dimvalue: Record "Dimension Value";
            begin
                ApprovalSetup.Reset();
                ApprovalSetup.SetRange(Department, "Department Code");
                if ApprovalSetup.Find('-') then begin
                    ApprovalSetup.TestField("Head of Department");
                    ApprovalSetup.TestField("Registrar VC");
                    ApprovalSetup.TestField("Registrar VC");

                    "Head of Department" := ApprovalSetup."Head of Department";
                    "Transport Officer" := ApprovalSetup."Registrar VC";
                    "Registrar HRM" := ApprovalSetup."Head Of Transport";
                    usr.Reset();
                    usr.SetRange("User Name", ApprovalSetup."Head of Department");
                    if usr.Find('-') then begin
                        "HOD UserName" := ApprovalSetup."Head of Department";
                        "HOD Name" := usr."Full Name";
                    end;
                end;
                dimvalue.Reset();
                dimvalue.SetRange(Code, "Department Code");
                if dimvalue.Find('-') then
                    "Department Name" := dimvalue.Name;

            end;
        }
        field(63; "Driver Name"; Text[100])
        {
        }
        field(64; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            // TableRelation = "FIN-Responsibility Center BR";

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                if not UserMgt.CheckRespCenter(1, "Department code") then
                    Error(
                      Text001
                      //RespCenter.TableCaption, UserMgt.GetPurchasesFilter
                      );
            end;
        }
        field(65; "Loaded to WorkTicket"; Boolean)
        {
        }
        field(66; "Time out"; Time)
        {
        }
        field(67; "Time In"; Time)
        {
        }
        field(68; "Journey Route"; Text[250])
        {
        }
        field(69; "Time Requested"; Time)
        {
        }
        field(70; "Closing Odometer Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(71; "Work Ticket No"; Code[20])
        {
        }
        field(72; "No of Days Requested"; Integer)
        {
        }
        field(73; "Authorized  By"; Text[30])
        {
        }
        field(74; Position; Text[30])
        {
        }
        field(75; "Department Name"; Text[100])
        {

        }
        field(80; "Recommed this Request"; Option)
        {
            OptionMembers = ,Yes,No;
            trigger OnValidate()
            begin
                if UserId() <> "Head of Department" then Error('You are not authorised to modify this Request');
                "HOD Approved Date" := WorkDate();
                "HoD  Approval Time" := Time;
            end;
        }
        field(81; "Recommendation Reason"; Text[500])
        {
            trigger OnValidate()
            begin
                if UserId() <> "Head of Department" then Error('You are not authorised to modify this Request');
            end;
        }
        field(894; "HoD  Approval Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "HOD UserName"; code[50])
        {
            Editable = false;
        }
        field(83; "Reg. No."; code[30])
        {
        }
        field(84; "Approved Request ?"; Option)
        {
            OptionMembers = ,Yes,"No";
            trigger OnValidate()
            var
                usr: Record Users;
            begin
                if UserId <> "Registrar HRM" then Error('You are not authorised to modify this Request');
                usr.Reset();
                usr.SetRange("User Name", "Registrar HRM");
                if usr.Find('-') then begin
                    "Admin Head Name" := usr."Full Name";
                    "Admin Head Username" := "Registrar HRM";
                    "VC  Approval Date" := WorkDate();
                    "VC Approval Time" := Time;
                end;
            end;
        }
        field(85; "Admin Head Name"; Text[200])
        {
            Editable = false;

        }
        field(565; "VC Approval Time"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registrar Approval Time';
        }
        field(564; "VC  Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registrar Approval Date';
        }
        field(86; "Admin Head Username"; code[50])
        {
            Editable = false;

        }
        field(87; "Head of Department"; code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(88; "Transport Officer"; code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(89; "Registrar HRM"; code[20])
        {

        }
        field(90; "Approval Stage"; Option)
        {
            OptionMembers = New,"Head of Department","Transport Officer","Registra HRM","Fully Approved";
        }
        field(91; "Duration to be Away"; Text[100])
        {

        }
        field(92; "HOD Approved"; Boolean)
        {

        }
        field(93; "TR Officer Approved"; Boolean)
        {

        }
        field(94; "Registra Approved"; Boolean)
        {

        }
        field(95; "Transport Officer Name"; Text[100])
        {

        }
        field(96; "HOD Approved Date"; date)
        {

        }
        field(97; "TR Approved Date"; date)
        {

        }
        field(98; "Admin Approved Date"; date)
        {

        }
        field(50000; Name; Code[200])
        {
        }
        field(50001; Signature; BLOB)
        {
        }
        field(50002; "Time of trip"; Time)
        {
        }
        field(50003; "Supervosor Recommendations"; Text[250])
        {
        }
        field(50004; "Date Requisition Received"; Date)
        {
        }
        field(50005; "Time Requisition Received"; Time)
        {
        }
        field(50006; "Transport Officer Remarks"; Text[250])
        {

            trigger OnValidate()
            begin
                "TO ID" := UserId;
                "TO Approval Date" := Today;
                userset.Reset;
                userset.SetRange(userset."User ID", UserId);
                if userset.Find('-') then begin
                    empno.Reset;
                    empno.SetRange(empno."No.", FltMgtSetup."Employee No.");
                    if empno.Find('-') then begin
                        "TO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                    end;
                end;
                Modify;
            end;
        }
        field(50007; "Checked By"; Code[50])
        {
        }
        field(50008; "Checked Designation"; Code[100])
        {
        }
        field(50009; "P/NO"; Code[20])
        {
        }
        field(50010; Designation; Code[50])
        {
        }
        field(50098; "Driver Contact number"; Text[60])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee Contact Number';
        }
        field(50011; "No Of Passangers"; Integer)
        {
            CalcFormula = Count("FLT-Travel Requisition Staff" WHERE("Req No" = FIELD("Transport Requisition No")));
            FieldClass = FlowField;
        }
        field(50012; "HOD Recommendations"; Text[100])
        {

            trigger OnValidate()
            begin
                "HOD ID" := UserId;
                "Checked By" := UserId;

                userset.Reset;
                userset.SetRange(userset."User ID", UserId);
                if userset.Find('-') then begin
                    empno.Reset;
                    empno.SetRange(empno."No.", FltMgtSetup."Employee No.");
                    if empno.Find('-') then begin
                        "HOD Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        "Checked Designation" := empno.Initials;
                    end;
                end;
                Modify;
            end;
        }
        field(50013; Make; Code[20])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Make WHERE("Registration No." = FIELD("Vehicle Allocated")));
            FieldClass = FlowField;
            Caption = 'Make I';
        }
        field(50014; Model; Code[20])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Model WHERE("Registration No." = FIELD("Vehicle Allocated")));
            FieldClass = FlowField;
            Caption = 'Model I';
        }
        field(50015; "Finance Officer Comments"; Text[250])
        {

            trigger OnValidate()
            begin
                "FO ID" := UserId;
                fltman5.Reset;
                fltman5.SetRange(fltman5.UserID, UserId);
                if fltman5.Find('-') then begin
                    if fltman5."Finance Approver" = true then begin
                        userset.Reset;
                        userset.SetRange(userset."User ID", UserId);
                        if userset.Find('-') then begin
                            empno.Reset;
                            empno.SetRange(empno."No.", FltMgtSetup."Employee No.");
                            if empno.Find('-') then begin
                                "FO Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                            end;
                        end;
                    end;
                end;

                Modify;
            end;
        }
        field(50016; "TO Name"; Text[150])
        {
        }
        field(50017; "FO Name"; Text[150])
        {
        }
        field(50018; "HOD Name"; Text[150])
        {
            Editable = false;
        }
        field(50019; "HOD ID"; Code[20])
        {
        }
        field(50020; "Checked By Name"; Code[150])
        {
        }
        field(50021; "FO ID"; Code[20])
        {
        }
        field(50022; "TO ID"; Code[20])
        {
        }
        field(50023; "TO Approval Date"; Date)
        {
        }
        field(50024; "Opening ODO"; Decimal)
        {
        }
        field(50025; "Clossing ODO"; Decimal)
        {
        }
        field(50026; "Nature of Trip"; Option)
        {
            /*  OptionCaption = ',Administrative,Business Travel,Research/Academic';
             OptionMembers = ,Administrative,"Business Travel","Research/Academic"; */
            OptionMembers = " ",Academic,"Administrative","Club Societies & Games",Welfare;
        }
        field(50027; Group; Code[20])
        {
            //TableRelation = "Trans.Groups".code;
        }
        field(50028; Mileage; Decimal)
        {
        }
        field(50029; "Emp No"; Code[20])
        {
            TableRelation = "HRM-Employee C"."No.";

            trigger OnValidate()
            begin
                IF Emp.GET("Emp No") THEN begin
                    "Employee Name" := (Emp."First Name") + ' ' + (Emp."Last Name");
                    Designation := emp."Job Title";
                    "Driver Contact number" := emp."Cellular Phone Number";
                end;

            end;
        }
        field(50030; "Employee Name"; Text[250])
        {
        }
        field(50031; "Estimated Mileage"; Decimal)
        {
        }
        field(50032; "Approved Rate"; Decimal)
        {
        }
        field(50033; "Fuel Unit Cost"; Decimal)
        {
        }
        field(505043; "Fuel Before trip"; Decimal)
        {
        }
        field(506043; "Fuel After trip"; Decimal)
        {
        }
        field(50034; "Total Cost"; Decimal)
        {
        }
        field(50035; "Return Date"; Date)
        {
        }
        field(50036; "Type of Vehicle"; Code[20])
        {
        }
        field(50037; "Mileage Before Trip"; Decimal)
        {
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
            end;
        }
        field(50038; "Milleage after Trip"; Decimal)
        {
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
                "Total Mileage Travelled" := rec."Mileage Before Trip" + rec."Milleage after Trip";
                rec.Modify();
            end;
        }
        field(50039; "Total Mileage Travelled"; Decimal)
        {
            Editable = false;
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');

            end;
        }
        field(50040; "Transport Return Date"; Date)
        {
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
            end;
        }
        field(50041; "Cost Per Kilometer"; Decimal)
        {
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
            end;
        }
        field(50043; "Vehicle Capacity"; Integer)
        {
            Caption = 'Vehicle I Capacity';
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
            end;
        }
        field(50044; "Return Confirmed By"; Code[20])
        {
        }
        field(50045; "Club/Societies"; Code[30])
        {
            //TableRelation = "Clubs & Societies"."Club/Society Code";
        }
        field(50046; "Transport Availability."; Option)
        {
            OptionCaption = ' ,Available,Not Available';
            OptionMembers = " ",Available,"Not Available";
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
            end;
        }
        field(50047; Submitted; Boolean)
        {
        }
        field(11; "Preferred Motor Vehicle "; Option)
        {
            OptionMembers = ,Bus,Lorry,"S-cab","D-cab";
        }
        field(50050; "Number of Passangers"; Integer)
        {

        }
        field(50051; "Estimated Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                if UserId <> "Transport Officer" then Error('You are not authorised to modify this Request');
            end;

        }
        field(50052; "Car Pool"; Boolean)
        {

        }
        //Vehicle II and Vehicle III
        field(50053; "Vehicle II"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
            Caption = 'Vehicle II';
        }
        field(50054; "Vehicle III"; Code[20])
        {
            TableRelation = "FLT-Vehicle Header"."Registration No.";
            Caption = 'Vehicle III';
        }
        field(50055; "Vehicle II Make"; Code[20])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Make WHERE("Registration No." = FIELD("Vehicle II")));
            FieldClass = FlowField;
            Caption = 'Make II';
        }
        field(50056; "Vehicle III Make"; Code[20])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Make WHERE("Registration No." = FIELD("Vehicle III")));
            FieldClass = FlowField;
            Caption = 'Make III';
        }
        field(50057; "Vehicle II Model"; Code[20])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Model WHERE("Registration No." = FIELD("Vehicle II")));
            FieldClass = FlowField;
            Caption = 'Model II';
        }
        field(50058; "Vehicle III Model"; Code[20])
        {
            CalcFormula = Lookup("FLT-Vehicle Header".Model WHERE("Registration No." = FIELD("Vehicle III")));
            FieldClass = FlowField;
            Caption = 'Model III';
        }
        field(50059; "Vehicle II Capacity"; Integer)
        {

        }
        field(50060; "Vehicle III Capacity"; Integer)
        {

        }
        //Drivers II and III
        field(50061; "Driver II"; Code[20])
        {

        }
        field(50062; "Driver III"; Code[20])
        {

        }
        field(50063; "Driver II Name"; Text[250])
        {

        }
        field(50064; "Driver III Name"; Text[250])
        {

        }
        field(50065; "Driver II Contact"; Text[250])
        {

        }
        field(50066; "Driver III Contact"; Text[250])
        {

        }
        //Driver DSA
        field(50067; "Driver I DSA"; Decimal)
        {

        }
        field(50068; "Driver II DSA"; Decimal)
        {

        }
        field(50069; "Driver III DSA"; Decimal)
        {

        }

    }

    keys
    {
        key(Key1; "Transport Requisition No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Transport Requisition No" = '' then begin
            FltMgtSetup.Get;
            FltMgtSetup.TestField(FltMgtSetup."Transport Req No");
            NoSeriesMgt.InitSeries(FltMgtSetup."Transport Req No", xRec."No. Series", 0D, "Transport Requisition No", "No. Series");
            "Date of Request" := Today();
            "Requested By" := UserId;
        end;
        /*  userset.Reset;
         userset.SetRange(userset."User ID", UserId);
         if userset.Find('-') then begin
             empno.Reset;
             empno.SetRange(empno."No.", FltMgtSetup."Employee No.");
             if empno.Find('-') then begin
                 // userset.CalcFields(userset."User Signature");
                 //Signature:=userset."User Signature";
                 Name := empno."First Name" + ' ' + empno."Middle Name" + ' ' + empno."Last Name";
                 "P/NO" := empno."No.";
                 Designation := empno.Initials;
             end else
                 Error('Please ensure that you have been setup by the System Administrator.')
         end; */
    end;

    trigger OnModify()
    begin
        //if (Status = Status::Approved) or (Status = Status::Approved) then
        //   Error(Text0001);

        if xRec."Vehicle Allocated" <> "Vehicle Allocated" then begin
            fltman5.Reset;
            fltman5.SetRange(fltman5."Transport Mger Approver", true);
            if fltman5.Find('-') then begin
                "Authorized  By" := fltman5.UserID;
                userset5.Reset;
                userset5.SetRange(userset5."User ID", fltman5.UserID);
                if userset5.Find('-') then begin
                    Emp1.Reset;
                    Emp1.SetRange(Emp1."No.", userset5."User ID");
                    if Emp1.Find('-') then begin
                        Position := Emp1.Initials;
                    end;
                end;
            end;
            Modify;
        end;
    end;

    var
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text0001: Label 'You cannot modify an Approved or Closed Record';
        HrEmployee: Record "HRM-Employee C";
        UserMgt: Codeunit "User Setup Management";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        // RespCenter: Record "FIN-Responsibility Center BR";
        userset: Record "User Setup";
        empno: Record "HRM-Employee C";
        fltman2: Record "FLT-Mgt Approval Setups";
        Emp: Record "HRM-Employee C";
        fltman4: Record "FLT-Mgt Approval Setups";
        fltman5: Record "FLT-Mgt Approval Setups";
        Emp1: Record "HRM-Employee C";
        userset5: Record "User Setup";
}

