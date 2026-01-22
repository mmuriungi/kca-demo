tableextension 50003 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Casuals  Register Nos"; Code[20])
        {

            TableRelation = "No. Series".Code;
        }
        field(56602; "Current Budget"; Text[100])
        {

            TableRelation = "No. Series".Code;
        }
        field(56603; "Current Budget Start Date"; Date)
        {

            TableRelation = "No. Series".Code;
        }
        field(56604; "Imprest No"; Code[20])
        {

            TableRelation = "No. Series".Code;
        }
        field(56605; "Normal Payments No"; Code[20])
        {

            TableRelation = "No. Series".Code;
        }
        field(56606; "Petty Cash Payments No"; Code[20])
        {

            TableRelation = "No. Series".Code;
        }
        field(56607; "Claims No"; Text[30])
        {

            TableRelation = "No. Series".Code;
        }
        field(56608; "Salary PV No"; Text[30])
        {

            TableRelation = "No. Series".Code;
        }
        field(56609; "Current Budget End Date"; Date)
        {

            TableRelation = "No. Series".Code;
        }
        field(56610; "Meals Booking No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(56611; "Cash Sale"; Code[20])
        {
            TableRelation = "No. Series".Code;

        }
        field(56612; "Cafeteria Sales Account"; Text[100])
        {
            TableRelation = "No. Series".Code;
        }
        field(56613; "Cafeteria Credit Sales Account"; Text[100])
        {
            TableRelation = "No. Series".Code;
        }
        field(56614; "Item Template"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(56615; "Item Batch"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(56616; "Cash Template"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(56617; "Cash Batch"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(56618; Remarks; Text[250])
        {
            Caption = 'Remarks';


        }
        field(56619; "Cheque Bank"; Text[250])
        {
            TableRelation = "No. Series".Code;
        }
        field(56620; "Staff Register Nos"; Text[250])
        {
            TableRelation = "No. Series".Code;
        }
        field(56621; "Visitor No."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(56622; "Safari Notice No."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(56623; "Transport Requisition No."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(56624; "Work Ticket No."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(56625; "Casual Staff Nos."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(56626; "Hotel Cus. Booking Posting G."; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(56627; "Deposit Nos."; Code[30])
        {
            TableRelation = "No. Series";

        }
        field(50000; "Bank Rec. Adj. Doc. Nos."; code[30])
        {
            TableRelation = "No. Series";
        }

    }

    var
        myInt: Integer;
}