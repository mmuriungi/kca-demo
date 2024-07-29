tableextension 50011 "Purchase Lines" extends "Purchase Line"
{
    fields
    {
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                gl: Record "G/L Account";
                itm: Record Item;
                fa: Record "Fixed Asset";
                Fpg: Record "FA Posting Group";
            begin
                if "Type" = "Type"::Item then begin
                    itm.reset;
                    itm.SetRange("No.", "No.");
                    if itm.Find('-') then
                        "Vote Book" := itm."Item G/L Budget Account";
                end else
                    if "Type" = "Type"::"G/L Account" then begin
                        "Vote Book" := "No.";
                    end else
                        if "Type" = "Type"::"Fixed Asset" then begin
                            fa.Reset();
                            fa.SetRange("No.", "No.");
                            if fa.Find('-') then begin
                                Fpg.Reset();
                                Fpg.SetRange("Code", fa."FA Posting Group");
                                if Fpg.Find('-') then
                                    "Vote Book" := Fpg."Acquisition Cost Account";
                            end;
                        end;
                gl.Reset();
                gl.SetRange("No.", "Vote Book");
                if gl.Find('-') then begin
                    "Vote Name" := gl.Name;
                end;

            end;

            trigger OnAfterValidate()
            var
                gl: Record "G/L Account";
                itm: Record Item;
                fa: Record "Fixed Asset";
                Fpg: Record "FA Posting Group";
            begin
                if "Type" = "Type"::Item then begin
                    itm.reset;
                    itm.SetRange("No.", "No.");
                    if itm.Find('-') then
                        "Vote Book" := itm."Item G/L Budget Account";
                end else
                    if "Type" = "Type"::"G/L Account" then begin
                        "Vote Book" := "No.";
                    end else
                        if "Type" = "Type"::"Fixed Asset" then begin
                            fa.Reset();
                            fa.SetRange("No.", "No.");
                            if fa.Find('-') then begin
                                Fpg.Reset();
                                Fpg.SetRange("Code", fa."FA Posting Group");
                                if Fpg.Find('-') then
                                    "Vote Book" := Fpg."Acquisition Cost Account";
                            end;
                        end;
                gl.Reset();
                gl.SetRange("No.", "Vote Book");
                if gl.Find('-') then begin
                    "Vote Name" := gl.Name;
                end;

            end;
        }
        field(56601; committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(56602; "Vote Book"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'ADDED THIS FIELD';
        }
        field(56603; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'ADDED THIS FIELD';
        }
        field(56604; "RFQ No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'ADDED THIS FIELD';
        }
        field(56605; "RFQ Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'ADDED THIS FIELD';
        }
        field(56606; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56607; "RFQ Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56608; "Project Code"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header".Lost WHERE("No." = FIELD("Document No.")));

        }
        field(56609; Status; Enum option)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("Purchase Header".Status WHERE("No." = FIELD("Document No."),
                                                                  "Document Type" = FIELD("Document Type")));
        }
        field(56610; "Asset No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";
        }
        field(56611; "Document Type 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Requisition,Quote,"Order";
        }
        field(56612; "Procurement Plan Item No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /* TESTFIELD("Shortcut Dimension 2 Code");
                 PrPlan.RESET;
                 PrPlan.SETRANGE(PrPlan.Department,"Shortcut Dimension 2 Code");
                 PrPlan.SETRANGE(PrPlan."Type No","Procurement Plan Item No");
                 IF PrPlan.FIND('-') THEN BEGIN
                 IF Quantity>PrPlan."Remaining Qty" THEN ERROR('The selected items is more than items on procurement plan');
                 PrPlan."Remaining Qty":=PrPlan."Remaining Qty"-Quantity;
                 PrPlan.MODIFY;
                 END;*/

            end;
        }
        field(56613; "Request for Quote No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header".Lost WHERE("Document Type" = FIELD("Document Type"),
                                                               "No." = FIELD("Document No.")));


            trigger OnValidate()
            begin
                /*   //CHECK WHETHER HAS LINES AND DELETE
                 IF NOT CONFIRM('If you change the Request for Quote No. the current lines will be deleted. Do you want to continue?',FALSE)
                 THEN
                     ERROR('You have selected to abort the process') ;

                     PurchLine.RESET;
                     PurchLine.SETRANGE(PurchLine."Document No.","No.");
                     PurchLine.DELETEALL;

                 RFQ.RESET;
                 RFQ.SETRANGE(RFQ."Document No.","Request for Quote No.");
                 IF RFQ.FIND('-') THEN BEGIN
                   REPEAT
                       PurchLine.INIT;
                       PurchLine."Document Type":="Document Type";
                       PurchLine."Document No.":="No.";
                       PurchLine."Line No.":=RFQ."Line No.";
                       PurchLine.Type:=RFQ.Type;
                       PurchLine."Document Type 2":="Document Type 2";
                       PurchLine."No.":=RFQ."No.";
                       PurchLine.VALIDATE("No.");
                       PurchLine."Location Code":=RFQ."Location Code";
                       PurchLine.VALIDATE("Location Code");
                       PurchLine.Quantity:=RFQ.Quantity;
                       PurchLine.VALIDATE(Quantity);
                       PurchLine."Direct Unit Cost":=RFQ."Direct Unit Cost";
                       PurchLine.VALIDATE("Direct Unit Cost");
                       PurchLine.Amount:=RFQ.Amount;
                       PurchLine.INSERT;
                   UNTIL RFQ.NEXT=0;
                 END;
                */

            end;
        }
        field(56614; "Line Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56615; "Budgeted Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Budget Entry".Amount WHERE("Global Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
                                                                "Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code"),

                                                               "Budget Name" = FIELD("Budget Name")));

        }
        field(56616; "Actual Expenditure"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("Vote Book"),
                                                         "Global Dimension 1 Code" = FIELD("Shortcut Dimension 1 Code"),
                                                         "Global Dimension 2 Code" = FIELD("Shortcut Dimension 2 Code")));
            //"Purch. Lost" = FIELD("Budget Name")


        }
        field(56617; "Committed Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum(Committment.Amount WHERE ("G/L Account No."=FIELD("Vote Book"),
            //                                             "Shortcut Dimension 1 Code"=FIELD("Shortcut Dimension 1 Code"),
            //                                             "Shortcut Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code"),
            //                                             Budget=FIELD("Budget Name")));

        }
        field(56618; "Budget Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name;
        }
        field(56619; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56620; "Description 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(56621; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50606; "Manual Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Quote),
                                                         Status = CONST(Released));

            trigger OnValidate()
            begin
                "Manually Added" := TRUE;
            end;
        }
        field(50607; "Manually Added"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51000; "RFQ Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51002; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51003; "Vote Name"; Text[100])
        {

        }
        field(9588696; lost; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(51004; "Procurement Plan"; code[20])
        {

        }
        field(51005; "Feature On The Plan"; Boolean)
        {

        }

        field(51006; Ordered; Boolean)
        {


        }
        field(51007; Archived; Boolean)
        {



        }
        field(51008; "Fully Issued"; Boolean)
        {



        }
        field(5100009; Select2; Boolean) { }
        field(5100010; "PO Type"; Option) { OptionMembers = LPO,LSO; }
        field(5100011; "Ordered by"; code[50]) { }
        field(5100012; "Order Creation date"; date) { }
        field(5100013; "Order Creation Time"; time) { }
        field(5100014; DocApprovalType; Option) { OptionMembers = Purchase,Requisition,Quote; }

        field(5100015; Decision; Option) { OptionMembers = Order; }
        field(5100016; "Selected By"; code[20]) { }





    }
}