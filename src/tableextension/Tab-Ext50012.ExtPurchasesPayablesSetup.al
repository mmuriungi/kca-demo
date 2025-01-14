tableextension 50012 "ExtPurchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(56601; "Stores Requisition No"; code[10])
        {
            Caption = 'Stores Requisition No';
            TableRelation = "No. Series";

        }
        field(56602; "Quotation Request No"; code[10])
        {
            Caption = 'Quotation Request No';
            TableRelation = "No. Series";
        }
        field(56603; "Internal Requisition No."; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56604; "Requisition Default Vendor"; code[20])
        {
            TableRelation = Vendor;
            trigger OnValidate()
            var
                Vend: record Vendor;
            begin
                Vend.RESET;
                IF Vend.GET(xRec."Requisition Default Vendor") THEN BEGIN
                    Vend."Requisition Default Vendor" := FALSE;
                    Vend.MODIFY;
                END;

                Vend.RESET;
                IF Vend.GET("Requisition Default Vendor") THEN BEGIN
                    Vend."Requisition Default Vendor" := TRUE;
                    Vend.MODIFY;
                END;
            end;
        }
        field(56605; "Requisition No"; code[30])
        {
            Caption = 'Requisition No';
            TableRelation = "No. Series";
        }
        field(56606; "Procurement Year Code"; Code[20])
        {
            Caption = 'Procurement Year Code';
        }
        field(56607; "Tender No."; code[30])
        {
            TableRelation = "No. Series";

        }
        field(56608; "Bid No."; code[30])
        {
            TableRelation = "No. Series";
        }
        field(56609; "Vendor Categories"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56610; "Doc Type"; Option)
        {
            OptionMembers = " ","Appointment Doc","Request for Quotation";

        }
        field(56611; "Direct Procurement"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56612; "Restricted tendering"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56613; "Two Stage Tender"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56614; Tender; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56615; "Tender Submission"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56616; "LSO Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56617; "Task Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(56618; "Project Mgt Nos"; code[20])
        {
            TableRelation = "No. Series";
            Caption = 'Contract Nos';
        }
        field(56619; "Contract End Days"; DateFormula)
        {

        }
    }


}