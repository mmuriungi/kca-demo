page 52178608 "Proc-Preq Year.Card"
{
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Proc-Prequalification Years";
    PromotedActionCategories = 'Add Category,Import,Reports';
    layout
    {
        area(Content)
        {
            group(general)
            {
                field("Preq. Year"; Rec."Preq. Year")
                {
                    Editable = yr;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq. Year field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    Editable = sdate;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = edate;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Preq. Categories"; Rec."Preq. Categories")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq. Categories field.';
                }
                field("Preq. Dates List"; Rec."Preq. Dates List")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq. Dates List field.';
                }
                field("Active Period"; Rec."Active Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active Period field.';
                }
            }
            group("Categories")
            {
                part(Cat; "Proc-Prequalif. Categories")
                {
                    ApplicationArea = All;
                    SubPageLink = "Preq Year" = field("Preq. Year");
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Import")
            {
                action("Update Suppliers")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = xmlport "Import Suppliers Preq";

                }
            }

            group(rep)
            {
                action("Prequalification Report")
                {
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Report;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        preqYC: Record "Proc-Prequalification Years";
                    begin
                        preqYC.RESET;
                        preqYC.SETRANGE("Preq. Year", Rec."Preq. Year");
                        REPORT.RUN(REPORT::"Proc-Prequalification Summary", TRUE, FALSE, preqYC);
                    end;
                }
            }
            group("Additions")
            {
                action("Add new Category")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Promoted = true;
                    Image = Category;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        Rec.AddCategory(Rec);
                    end;
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        editability();
    end;

    var
        yr: Boolean;
        sdate: Boolean;
        edate: Boolean;

    procedure editability()
    begin
        yr := true;
        sdate := true;
        edate := true;

        if Rec."Preq. Year" <> '' then
            yr := false;
        if Rec."Start Date" <> 0D then
            sdate := false;
        if Rec."End Date" <> 0D then
            edate := false;
    end;
}