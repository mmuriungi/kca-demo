tableextension 52178701 "ExtPurchase Line" extends "Purchase Line"
{
    fields
    {
        field(6000; committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6001; "Vote Book"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6002; "Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(6003; "RFQ No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6004; "RFQ Line No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(6005; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6006; "RFQ Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(6007; "Project Code"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header".Lost WHERE("No." = FIELD("Document No.")));
            Editable = false;
        }
        field(6008; Status; Enum "Purchase Document Status")
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("Purchase Header".Status WHERE("No." = FIELD("Document No."),
                                                                 "Document Type" = FIELD("Document Type")));
        }
        field(6009; "Asset No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";
        }
        field(6010; "Document Type 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Requisition,Quote,"Order";
        }
        field(6011; "Procurement Plan Item No"; Code[20])
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
        field(6012; "Request for Quote No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Header".Lost WHERE("Document Type" = FIELD("Document Type"),
                                                               "No." = FIELD("Document No.")));
            Editable = false;
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
                       PurchLine.INSERT(True);
                   UNTIL RFQ.NEXT=0;
                 END;
                */

            end;
        }
        field(6013; "Line Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6014; "Budgeted Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("G/L Budget Entry".Amount WHERE ("Global Dimension 1 Code"=FIELD("Shortcut Dimension 1 Code"),
            //                                                    "Global Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code"),
            //                                                    "G/L Account No."=FIELD("Vote Book"),
            //                                                    "Budget Name"=FIELD("Budget Name")));

        }
        field(6015; "Actual Expenditure"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("Vote Book"),
            //                                             "Global Dimension 1 Code"=FIELD("Shortcut Dimension 1 Code"),
            //                                             "Global Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code"),
            //                                             "Purch. Lost"=FIELD("Budget Name")));

        }
        field(6016; "Committed Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum(Committment.Amount WHERE ("G/L Account No."=FIELD("Vote Book"),
            //                                             "Shortcut Dimension 1 Code"=FIELD("Shortcut Dimension 1 Code"),
            //                                             "Shortcut Dimension 2 Code"=FIELD("Shortcut Dimension 2 Code"),
            //                                             Budget=FIELD("Budget Name")));

        }
        field(6017; "Budget Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name".Name;
        }
        field(6018; "Budget Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6019; "Description 3"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(6020; DocApprovalType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Requisition,Quote,Capex;
        }
        field(6021; "Procurement Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6022; "Manual Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Quote),
                                                         Status = CONST(Released));

            trigger OnValidate()
            begin
                "Manually Added" := TRUE;
            end;
        }
        field(6023; "Manually Added"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6024; "RFQ Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6025; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6026; lost; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6027; Select2; Boolean)
        {
            Caption = 'Select';
            trigger OnValidate()
            begin

                MODIFY(FALSE);

                "Selected By" := USERID;
            end;

        }
        field(6028; Ordered; Boolean)
        {

        }
        field(6029; "PO Type"; Option)
        {
            Caption = 'Order Type';
            OptionCaption = ' ,LPO,LSO';
            OptionMembers = " ",LPO,LSO;
            trigger OnValidate()
            begin
                if Select2 = false then Error('First select then choose Order type');
                Decision := Decision::Order;
            end;


        }
        field(6030; "PO Number"; Code[20])
        {
            TableRelation = "Purchase Header"."No." WHERE("Document Type 2" = filter(Requisition),
                                                         Status = CONST(Open));

            trigger OnValidate()
            begin
                MODIFY(FALSE);
            end;
        }
        field(6031; "Selected By"; Code[50])
        {
        }
        field(6032; Category; Option)
        {
            OptionCaption = ' ,Item,Service,Capex';
            OptionMembers = " ",Item,Service,Capex;

            trigger OnValidate()
            begin

                //Ushindi

                TestStatusOpen;
                IF Category = Category::Item THEN BEGIN
                    //INSERT(TRUE);
                    // MODIFY(TRUE);
                    Type := Type::Item
                    //END ELSE IF Category=Category::Service THEN BEGIN
                    //Type:=Type::"G/L Account";


                END;
            end;
        }
        field(6033; "Ordered by"; code[100])
        {

        }

        field(6034; "Order Creation date"; date)
        {

        }
        field(6035; "Order Creation Time"; time)
        {

        }
        field(6036; "Fully Issued"; Boolean)
        {
        }
        field(6037; Decision; Option)
        {
            OptionCaption = ' ,Order';
            OptionMembers = " ","Order";
        }
        field(6038; "Procurement Plan"; Code[30])
        {
            TableRelation = "PROC-Procurement Plan Header"."Budget Name";
        }
        field(6039; "Feature On The Plan"; Boolean)
        {

        }
        field(6040; Archived; Boolean)
        {
            Editable = false;
        }
        field(6041; "No of Days"; Integer)
        {

        }
        field(6042; "Claim No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6043; "Claim Type"; Enum "Claim Type")
        {
            DataClassification = ToBeClassified;
        }


    }


    trigger OnInsert()

    var
        pheader: Record "PROC-Procurement Plan Header";
    begin
        Rec."Location Code" := 'MAIN STORE';
        pheader.Reset();
        pheader.SetRange("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
        pheader.SetRange(Active, true);
        if pheader.Find('-') then begin
            Rec."Procurement Plan" := pheader."Budget Name";
        end;
        ;// else
         // Error('No Active Procurement Plan');
    end;

    procedure CheckPlan(var prline: Record "Purchase Line")
    var
        plHead: Record "PROC-Procurement Plan Header";
        pLine: Record "PROC-Procurement Plan Lines";
        Pperiods: Record "Proc Plan Periods";
    begin
        Pperiods.Reset();
        Pperiods.SetRange(Current, true);
        Pperiods.SetRange(Closed, false);
        if Pperiods.Find('-') then begin
            plHead.Reset();
            plhead.SetRange("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
            plHead.SetRange(Active, true);
            if plHead.Find('+') then begin
                pLine.Reset();
                pline.SetRange("Budget Name", plHead."Budget Name");
                pline.SetRange("No.", prline."No.");
                if not pLine.Find('-') then begin
                    Error('The Item is not budgeted for');
                end;
            end;// else
                //  Error('No Active Procurement Plan');
        end else
            Error('No open period available');

    end;

    procedure CheckPlanQTY(var prline: Record "Purchase Line")
    var
        plHead: Record "PROC-Procurement Plan Header";
        pLine: Record "PROC-Procurement Plan Lines";
        qty: Decimal;
        qtyp: Decimal;
        qtyR: Decimal;
    begin
        qty := 0;
        plHead.Reset();
        plHead.SetRange("Global Dimension 1 Code", plHead."Global Dimension 1 Code");
        plHead.SetRange(Active, true);
        if plHead.Find('+') then begin
            pLine.Reset();
            pLine.SetRange("Global Dimension 1 Code", plHead."Global Dimension 1 Code");
            pline.SetRange("Budget Name", plHead."Budget Name");
            pline.SetRange("No.", prline."No.");
            if pLine.Find('-') then begin
                repeat
                    pLine.CalcFields("Quantity Requisitioned");
                    qty := qty + pLine.Quantity;
                    qtyp := pLine."Quantity Requisitioned";
                until pLine.Next() = 0;
            end;
            qtyR := qty - qtyp;

            if prline.Quantity > qtyR then Error('You cannot requisition above the budgeted quantity in the Plan');

        end;
    end;
}