report 50359 "CAT-Sales Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CAT-Sales Register.rdl';

    dataset
    {
        dataitem("CAT-Cafeteria Receipts"; "CAT-Cafeteria Receipts")
        {
            DataItemTableView = WHERE(Status = FILTER(Posted));
            column(pic; info.Picture)
            {
            }

            column(tittle; 'RECEIPTS REGISTER')
            {
            }
            column(DateFilter; "CAT-Cafeteria Receipts"."Receipt Date")
            {
            }
            column(CafeSections; "CAT-Cafeteria Receipts".Sections)
            {
            }
            column(seq; seq)
            {
            }
            column(itemCode; "CAT-Cafeteria Receipts"."Receipt No.")
            {
            }
            column(Desc; "CAT-Cafeteria Receipts".User)
            {
            }
            column(ItemPrice; "CAT-Cafeteria Receipts"."Recept Total")
            {
            }
            column(RepStatus; "CAT-Cafeteria Receipts".Status)
            {
            }
            column(warning; 'The Cafeteria Management reserves the right to sell an Item on the menu')
            {
            }
            column(bonapettie; '***************************************** BON APETTIE *****************************************')
            {
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;

            trigger OnPreDataItem()
            begin
                "CAT-Cafeteria Receipts".Reset;
                "CAT-Cafeteria Receipts".SetFilter("CAT-Cafeteria Receipts"."Receipt Date", '=%1', DateFilter);
                "CAT-Cafeteria Receipts".SetFilter("CAT-Cafeteria Receipts"."Cafeteria Section", '=%1', CafeSections);
                "CAT-Cafeteria Receipts".SetRange("CAT-Cafeteria Receipts".Status, "CAT-Cafeteria Receipts".Status::Posted);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Report_Filter)
                {
                    Caption = 'Report Filter';
                    field(DateFilter; DateFilter)
                    {
                        Caption = 'Date Filter';
                    }
                    field(CafeSections; CafeSections)
                    {
                        Caption = 'Cafe. Sections';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        DateFilter := Today;
    end;

    trigger OnPreReport()
    begin
        info.Reset;
        if info.Find('-') then begin
            info.CalcFields(info.Picture);
        end;
        Clear(seq);
        if DateFilter = 0D then Error('Please specify a date.');
        if CafeSections = CafeSections::" " then Error('Specify the Cafeteria section!');
    end;

    var
        DateFilter: Date;
        CafeSections: Option " ",Students,Staff;
        info: Record "Company Information";
        seq: Integer;
}

