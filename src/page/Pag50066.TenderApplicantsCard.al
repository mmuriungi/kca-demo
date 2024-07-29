page 50066 "Tender Applicants Card"
{
    SourceTable = "Tender Applicants Registration";
    PageType = card;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field.';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    ApplicationArea = All;
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                    ApplicationArea = All;
                }
                field("Changed Password"; Rec."Changed Password")
                {
                    ToolTip = 'Specifies the value of the Changed Password field.';
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ToolTip = 'Specifies the value of the Contact Person field.';
                    ApplicationArea = All;
                }
                field("Contact Person Email"; Rec."Contact Person Email")
                {
                    ToolTip = 'Specifies the value of the Contact Person Email field.';
                    ApplicationArea = All;
                }


                group(Reg)
                {
                    Caption = 'Registrations & Compliance';

                    field("Certificate of Incoporation"; Rec."Certificate of Incoporation")
                    {
                        ToolTip = 'Specifies the value of the Certificate of Incoporation field.';
                        ApplicationArea = All;
                    }
                    field("Pin Registration Certificate"; Rec."Pin Registration Certificate")
                    {
                        ToolTip = 'Specifies the value of the Pin Registration Certificate field.';
                        ApplicationArea = All;
                    }
                    field("VAT Registration Certificate"; Rec."VAT Registration Certificate")
                    {
                        ToolTip = 'Specifies the value of the VAT Registration Certificate field.';
                        ApplicationArea = All;
                    }
                    field("Tax Compliance Certificate"; Rec."Tax Compliance Certificate")
                    {
                        ToolTip = 'Specifies the value of the Tax Compliance Certificate field.';
                        ApplicationArea = All;
                    }
                    field("VAT Registration No."; Rec."VAT Registration No.")
                    {
                        ToolTip = 'Specifies the value of the VAT Registration No. field.';
                        ApplicationArea = All;
                    }
                }

            }
        }
    }

}