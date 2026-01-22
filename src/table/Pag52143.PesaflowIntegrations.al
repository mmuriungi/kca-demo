page 52143 "Pesaflow Integrations"
{
    ApplicationArea = All;
    Caption = 'Pesaflow Integrations';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "PesaFlow Integration";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(CustomerRefNo; Rec.CustomerRefNo)
                {
                    ToolTip = 'Specifies the value of the Customer Ref No field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(PaidAmount; Rec.PaidAmount)
                {
                    ToolTip = 'Specifies the value of the Paid Amount field.';
                }
                field(PaymentDate; Rec.PaymentDate)
                {
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field("Selected And Posted"; Rec."Selected And Posted")
                {
                    ToolTip = 'Specifies if the record has been selected and posted.';
                    applicationArea = All;
                }
                field(PaymentRefID; Rec.PaymentRefID)
                {
                    ToolTip = 'Specifies the value of the Payment Ref ID field.';
                }
                field(InvoiceAmount; Rec.InvoiceAmount)
                {
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
            }
        }
    }
}
