tableextension 52178702 "ExtPurchase Header" extends "Purchase Header"
{
    fields
    {

        field(6063; "Quote Status"; Option)
        {
            OptionMembers = Pending,Submitted,Recalled,"Prelim Qualif","Prelim Disqualif","Tech Qualf","Tech Disqualif","Demo Qualif","Demo Disqualif","Fin Qualif","Fin Disqualif","Recommended Award";
        }




        field(6082; "Shortcut Dimension 3 Code"; code[50])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".code where("Global Dimension No." = const(3));

        }
        field(6083; "Shortcut dimension 4 Code"; code[50])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".code where("Global Dimension No." = const(4));
        }

        field(6067; "Departments Name"; text[100])
        {

            DataClassification = ToBeClassified;
        }

        field(6068; "Assigned User ID 2"; code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6022; "Request for Quote No."; Code[50])
        {
            TableRelation = "PROC-Purchase Quote Header"."No.";
            //TableRelation = "PROC-Quotation Request Vendors"."Document No." WHERE("Vendor No." = FIELD("Buy-from Vendor No."));

            trigger OnValidate()
            var
            begin
                IF NOT CONFIRM('If you change the Request for Quote No. the current lines will be deleted. Do you want to continue?', FALSE)
              THEN
                    ERROR('You have selected to abort the process');

                PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                PurchLine.DELETEALL;

                RFQ_Line.RESET;
                RFQ_Line.SETRANGE(RFQ_Line."Document No.", "Request for Quote No.");
                IF RFQ_Line.FIND('-') THEN BEGIN
                    REPEAT
                        PurchLine.RESET;
                        PurchLine.SETRANGE("Document No.", "No.");
                        IF PurchLine.FIND('-') THEN BEGIN
                            countedRec := PurchLine.COUNT + 1;
                        END ELSE
                            countedRec := 1;
                        PurchLine.INIT;
                        PurchLine."Document Type" := PurchLine."Document Type"::Quote;
                        PurchLine."Document No." := "No.";
                        PurchLine."Line No." := countedRec;
                        PurchLine."Type" := RFQ_Line."Type";
                        PurchLine."No." := RFQ_Line."No.";
                        PurchLine."RFQ No." := RFQ_Line."Document No.";
                        PurchLine.VALIDATE("No.");
                        PurchLine."Location Code" := RFQ_Line."Location Code";
                        PurchLine.VALIDATE("Location Code");
                        PurchLine.Quantity := RFQ_Line.Quantity;
                        PurchLine."Description 2" := RFQ_Line."Description 2";
                        PurchLine.VALIDATE(Quantity);
                        PurchLine."Direct Unit Cost" := RFQ_Line."Direct Unit Cost";
                        PurchLine.VALIDATE("Direct Unit Cost");
                        PurchLine.Amount := RFQ_Line.Amount;
                        PurchLine.INSERT(True);
                    UNTIL RFQ_Line.NEXT = 0;
                END;
                vend.Reset();
                vend.SetRange("No.", "Bidder No.");
                if vend.find('-') then begin
                    "Buy-from Vendor No." := vend."No.";
                    "Buy-from Vendor Name" := vend.Name;
                    "Pay-to Name" := vend.Name;

                    purline.Reset();
                    purline.SetRange("Document No.", "No.");
                    purline.SetRange("Document Type", "Document Type");
                    if purline.find('-') then begin
                        repeat
                            purline."Buy-from Vendor No." := vend."No.";
                            purline."Pay-to Vendor No." := vend."No.";
                            purline.Modify();
                        until purline.Next() = 0;
                    end;

                end;

            end;



        }


        field(6071; "Request Narration"; text[2048])
        {

        }
        field(6072; "Winning Bid"; Code[30])
        {

        }
        field(6073; "Expected Closing Date"; DateTime)
        {

        }
        field(6074; "Expected Opening Date"; DateTime)
        {

        }
        field(6075; "Bidder No."; Code[30])
        {

            TableRelation = if ("Procurement Method" = filter("Open Tendering")) "Tender Applicants Registration"."No."
            else
            "PROC-Quotation Request Vendors"."Vendor No." where("Document No." = field("Request for Quote No."));
            trigger OnValidate()
            var
                TenderBidders: Record "Tender Applicants Registration";
                vend: Record Vendor;
                purline: Record "Purchase Line";
            begin
                vend.Reset();
                vend.SetRange("No.", "Bidder No.");
                if vend.find('-') then begin
                    "Buy-from Vendor No." := vend."No.";
                    "Buy-from Vendor Name" := vend.Name;
                    "Pay-to Name" := vend.Name;
                    Validate("Buy-from Vendor No.");
                    purline.Reset();
                    purline.SetRange("Document No.", "No.");
                    purline.SetRange("Document Type", "Document Type");
                    if purline.find('-') then begin
                        repeat
                            purline."Buy-from Vendor No." := vend."No.";
                            Validate("Buy-from Vendor No.");
                            purline."Pay-to Vendor No." := vend."No.";
                            Validate("Pay-to Vendor No.");
                            purline.Modify();
                        until purline.Next() = 0;
                    end;
                end;
                TenderBidders.Reset();
                TenderBidders.SetRange("No.", "Bidder No.");
                if TenderBidders.find('-') then begin
                    "Buy-from Vendor No." := TenderBidders."No.";
                    "Buy-from Vendor Name" := TenderBidders.Name;
                    "Pay-to Name" := TenderBidders.Name;
                    purline.Reset();
                    purline.SetRange("Document No.", "No.");
                    purline.SetRange("Document Type", "Document Type");
                    if purline.find('-') then begin
                        repeat
                            purline."Buy-from Vendor No." := TenderBidders."No.";
                            purline."Pay-to Vendor No." := TenderBidders."No.";
                            purline.Modify();
                        until purline.Next() = 0;
                    end;
                end;
            end;
        }
        field(6076; "Technical Evaluation"; Decimal)
        {

        }
        field(6077; "Demo Evaluation"; Decimal)
        {

        }
        field(6078; "Final Technical/Demo"; Decimal)
        {

        }
        field(6079; "Financial Score"; Decimal)
        {

        }
        field(6080; "Total Score"; Decimal)
        {

        }
        field(6081; "Responsibility Centers"; Code[30])
        {
            TableRelation = "Responsibility Center".Code;

            trigger OnValidate()
            begin
                Rec."Responsibility Center" := rec."Responsibility Centers";

            end;

        }







        field(52178506; "Memo No"; code[50])
        {
            Editable = false;
        }
        field(52178508; "Memo Description"; Text[2048])
        {
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                dim: record "Dimension Value";
            begin
                dim.Reset();
                dim.SetRange(code, rec."Shortcut Dimension 1 Code");
                if dim.Find('-') then begin
                    "Directorate Name" := dim.Name;
                end;
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            var
                dim: record "Dimension Value";
            begin
                dim.Reset();
                dim.SetRange(code, rec."Shortcut Dimension 2 Code");
                if dim.Find('-') then begin
                    "Department Name" := dim.Name;
                end;
            end;
        }

        field(50000; Copied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Debit Note"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Procurement Request No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Invoice Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Purchase Line"."Line Amount"
            WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));


        }
        field(50005; "Request No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Commited; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Department; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Dimension Value".Code WHERE("Dimension Code" = Filter("Department"));
        }
        field(50008; "Delivery No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Ledger Card No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "PRN No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Purchasing,Finance,Admin,Completed';
            OptionMembers = New,Purchasing,Finance,Admin,Completed;
        }
        field(50012; "PO Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(50013; "Finance Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(50014; "Admin Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(50015; "P.O Name"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "P.O Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Finance Approved By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Finance Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Admin Approved By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Admin Approved Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Contract No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Quotation No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50034; "Document Type 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Requisition,Quote,"Order";
            trigger OnValidate()
            var
                Commit: record "FIN-Committment";

            begin
                CalcFields("Document Type");
                REC.TestField("Document Type");
                commit."Document Type" := rec."Document Type 2";
            end;
        }
        field(50040; "Tendor Number"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; Allocation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50042; Expenditure; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Purchase Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Departmental,Global';
            OptionMembers = " ",Departmental,Global;
        }
        field(50045; "Budgeted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50046; "Actual Expenditure"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50047; "Committed Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50048; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50049; "Reference No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Refrence Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee';
            OptionMembers = Employee,Student;
        }
        field(50061; "Quote Comments"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Store Comments of Purchase Quote in the DB (Added)';
        }
        field(50062; "Responsibility Center Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Responsibilty Center Name in the database (Added)';
        }
        field(50063; "Donor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Donor Name in the database (Added)';
        }
        field(50064; "Pillar Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores Pillar Name in the database (Added)';
        }
        field(50065; "Quote Comments 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Quote Comments 3"; Text[30])
        {
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(50067; "Recommendation 1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Recommendation 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Project Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Archive Unused Doc"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "VAT Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Expensed,Recovered';
            OptionMembers = Expensed,Recovered;
        }
        field(50072; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50073; "Cancelled By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Cancelled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote,Capex;
        }
        field(50076; "Procurement Type Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Invoice Basis"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "PO Based","Direct Invoice";
        }
        field(50078; "RFQ No."; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            begin
                TESTFIELD("Responsibility Center");
                TESTFIELD("Shortcut Dimension 1 Code");
                TESTFIELD("Shortcut Dimension 2 Code");
                /*
                RFQHdr.RESET;
                RFQHdr.SETRANGE(RFQHdr.lost,RFQHdr.lost::"1");
                IF PAGE.RUNMODAL(39006069,RFQHdr) = ACTION::LookupOK THEN
                  InsertRFQ(RFQHdr);*/

            end;
        }
        field(50079; "Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Special Remark"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50081; "Responsible Officer"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50082; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,LPO,LSO';
            OptionMembers = " ",LPO,LSO;
        }
        field(50083; "Imprest Purchase Doc No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Manual LPO No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "Requisition No."; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Line".lost WHERE("Document No." = FIELD("No.")));
            Editable = false;
        }
        field(50086; "LPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50087; Contract; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*  CALCFIELDS("Invoice Amount");
                  IF "Invoice Amount"<1000000 THEN ERROR('Please note that contract LPO is only applicable for LPOs with a value of 1million and above');
                  Status:=Status::Released;*/

            end;
        }
        field(50088; "Cum. Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50089; "Is Milk"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20922932; Lost; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(52178501; "Job Title"; text[100])
        {

        }


        field(52178700; "Shortcut Dimension  3"; code[50])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = const(3));
            trigger OnValidate()
            var
                dim: Record "Dimension Value";
            begin
                dim.Reset();
                dim.SetRange("Dimension Code", "Shortcut Dimension  3");
                if dim.FindFirst() then
                    "Division Name" := dim.Name;



            end;
        }
        field(52178701; "Shortcut dimension 4"; code[50])
        {
            TableRelation = "Dimension Value".code where("Global Dimension No." = const(4));
        }
        field(52178500; "Division Name"; text[100])
        {

        }


        field(52178502; "Department Name"; text[100])
        {

            DataClassification = ToBeClassified;
        }
        field(52178505; "Directorate Name"; text[100])
        {

        }
        field(52178503; "User Id"; code[50])
        {
            caption = 'Created By';
            DataClassification = ToBeClassified;
            //tablerelation = "User Setup"."User ID";

        }
        field(52178504; "PO Type"; Option)
        {
            OptionCaption = ' ,LSO,LPO';
            OptionMembers = " ",LSO,LPO;
        }
        field(52178507; "Date Approved"; date)
        {
            Editable = false;
        }

        field(52178509; Archived; Boolean)
        {
            Editable = false;
        }
        field(52178510; "Procurement Method"; Enum "Proc-Procurement Methods")
        {

        }
        field(52178511; "Claim No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //claim type
        field(52178512; "Claim Type"; Enum "Claim Type")
        {
            DataClassification = ToBeClassified;
        }
        //Batch No
        field(52178513; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }




    trigger OnInsert()
    begin
        if "No." = ' ' then begin


        end;


        PurchSetup.Reset();
        if PurchSetup.find('-') then;
        PurchSetup.TestField("Requisition Default Vendor");
        if vend.get(PurchSetup."Requisition Default Vendor") then;
        IF DocApprovalType = DocApprovalType::Requisition THEN BEGIN
            "Buy-from Vendor No." := PurchSetup."Requisition Default Vendor";
            VALIDATE("Buy-from Vendor No.");
            Rec.Validate("Buy-from Vendor Name", vend.Name);
            // "Quote No." := "No."
        END
    end;






    procedure FeatureonPlan(var pheader: Record "Purchase Header")
    var
        purline: record "Purchase Line";
        plan: Record "PROC-Procurement Plan Header";

    begin
        if Rec.DocApprovalType = Rec.DocApprovalType::Requisition then begin
            plan.Reset();
            plan.SetRange(Active, true);
            if plan.Find('-') then begin

                purline.Reset();
                purline.SetRange("Document No.", pheader."No.");
                if purline.Find('-') then begin
                    repeat
                        purline."Feature On The Plan" := true;
                        purline.DocApprovalType := purline.DocApprovalType::Requisition;
                        purline."Procurement Plan" := plan."Budget Name";
                        purline.Modify();

                    until purline.Next() = 0;
                end;
            end else
                Error('No Active Plan');
        end;

    end;

    procedure RemoveFromPlan(var pheader: Record "Purchase Header")
    var
        purline: record "Purchase Line";
    begin
        if Rec.DocApprovalType = Rec.DocApprovalType::Requisition then begin
            purline.Reset();
            purline.SetRange("Document No.", pheader."No.");
            if purline.Find('-') then begin
                repeat
                    purline."Feature On The Plan" := false;
                    purline.Modify();
                until purline.Next() = 0;
            end;

        end;

    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        Vend: Record Vendor;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        usersetup: record "User Setup";
        employee: Record "HRM-Employee C";
        "Employee Name": text[100];
        "Job titile": text[100];
        purline: Record "Purchase Line";
        RFQ: Record "PROC-Purchase Quote Line";
        RFQ_Line: Record "PROC-Purchase Quote Line";
        countedRec: Integer;
        PurchLine: Record "Purchase Line";



}