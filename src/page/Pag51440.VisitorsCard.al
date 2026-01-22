page 51440 "Visitors Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Visitor Card";
    Caption = 'Visitors Card';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    Editable = Id;
                    ApplicationArea = All;

                }
                field("Full Names"; Rec."Full Names")
                {
                    Editable = fname;
                    ApplicationArea = All;

                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = Phone;
                    ApplicationArea = All;

                }
                field(Email; Rec.Email)
                {
                    Editable = mail;
                    ApplicationArea = All;

                }
                field("Company Name"; Rec."Company Name")
                {
                    Editable = comp;
                    ApplicationArea = All;

                }
                field(County; Rec.County)
                {
                    Editable = Cnty;
                    ApplicationArea = All;

                }
                field("Vehicle Registration Number"; Rec."Vehicle Registration Number")
                {
                    Editable = vehicle;
                    ApplicationArea = All;

                }
                field("Reg. Date"; Rec."Reg. Date")
                {
                    ApplicationArea = All;

                }
                field("Reg. Time"; Rec."Reg. Time")
                {
                    ApplicationArea = All;

                }
                field("Registered By"; Rec."Registered By")
                {
                    ApplicationArea = All;

                }
                field("No. of Visits"; Rec."No. of Visits")
                {
                    ApplicationArea = All;
                }
                field("Checked Out By"; Rec."Checked Out By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Checked Out By field.';
                }
                field("Checkout Time"; Rec."Checkout Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Checkout Time field.';
                }
                field("Checkout Date"; Rec."Checkout Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Checkout Date field.';
                }
                field("Checked Out"; Rec."Checked Out")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Checked Out field.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Checkout)
            {
                Visible = Checkt;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = CheckRulesSyntax;

                trigger OnAction()
                begin
                    if Confirm('Confirm Checkout', true) = false then Error('Cancelled');
                    Rec."Checked Out By" := UserId;
                    Rec."Checkout Date" := Today;
                    Rec."Checkout Time" := System.Time();
                    Rec."Checked Out" := true;
                    rec.Modify();
                end;

            }
        }
    }
    var
        [InDataSet]
        Id, fname, Phone, mail, comp, cnty, vehicle, Checkt : Boolean;

    trigger OnOpenPage()
    begin
        validateEdit();
    end;

    procedure validateEdit()
    begin
        fname := true;
        Id := true;
        Phone := true;
        mail := true;
        Cnty := true;
        vehicle := true;
        vehicle := true;
        Checkt := true;
        if Rec."ID No." <> '' then
            Id := false;

        if Rec."Full Names" <> '' then
            fname := false;
        if Rec."Phone No." <> '' then
            Phone := false;

        if Rec.Email <> '' then
            mail := false;

        if Rec."Company Name" <> '' then
            comp := false;

        if Rec.County <> '' then
            Cnty := false;

        if Rec."Vehicle Registration Number" <> '' then
            vehicle := false;

        if rec."Checked Out" = true then
            Checkt := false;

    end;
}

