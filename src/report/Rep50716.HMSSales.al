report 50716 "HMS-Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMS-Sales.rdl';
    Caption = 'HMS-Sales';
    dataset
    {
        dataitem(HMSTreatmentFormDrug; "HMS-Treatment Form Drug")
        {
            column(TreatmentNo; "Treatment No.")
            {
            }
            column(DrugNo; "Drug No.")
            {
            }
            column(DrugName; "Drug Name")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(UnitOfMeasure; "Unit Of Measure")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(PharmacyCode; "Pharmacy Code")
            {
            }
            column("Compnay_Name"; info.Name)
            {

            }
            column("Compnay_Picture"; info.Picture)
            {

            }
            column("Compnay_Email"; info."E-Mail")
            {

            }
            column(ActualQuantity; "Actual Quantity")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(Issued; Issued)
            {
            }
            column(Dosage; Dosage)
            {
            }
            column(MarkedasIncompatible; "Marked as Incompatible")
            {
            }
            column(ProductGroup; "Product Group")
            {
            }
            column(NostockDrugs; "No stock Drugs")
            {
            }
            column(Price; Price)
            {
            }
            column(UnitofMeasureII; "Unit of Measure II")
            {
            }
            column(PharmacyNo; "Pharmacy No.")
            {
            }
            column(Quantitytoissue; "Quantity to issue")
            {
            }
            column(QuantityInStore; "Quantity In Store")
            {
            }
            column(RouteofAdministration; "Route of Administration")
            {
            }
            column(DosageFrequencies; "Dosage Frequencies ")
            {
            }
            column(NumberOfDays; "Number Of Days")
            {
            }
            column(unitcost; "unit cost ")
            {
            }
            column(TotalCost; " Total Cost")
            {
            }
            column(TotalNumberOfTablets; " Total Number Of Tablets")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        info.get;
        info.CalcFields(Picture);
    end;

    var
        info: Record "Company Information";
}
