using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using CLIPSNET;

namespace Alchemy
{
    public class Fact
    {
        public int FactID { get; }

        public double Assurance { get; set; }

        public string Description { get; }

        public Fact(int factID, string description, double assurance = 0.95)
        {
            Assurance = assurance;
            FactID = factID;
            Description = description;
        }

        public Fact(List<SlotValue> slotValues)
        {
            FactID = int.Parse(slotValues[0].Contents);
            Description = slotValues[1].Contents;
            Assurance = double.Parse(slotValues[2].Contents, CultureInfo.InvariantCulture);
        }

        public override int GetHashCode()
        {
            return FactID.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            if (obj is Fact)
            {
                return FactID == (obj as Fact).FactID;
            }
            return false;
        }

        public override string ToString()
        {
            return $"Fact id: {FactID}, decsription: {Description}";
        }

        public string ToClips(bool withAssurance = true)
        {
            string assurance = withAssurance ? $"(assurance {Assurance.ToString(CultureInfo.InvariantCulture)})" : "";
            return $"(fact (id {FactID}) (name {Description.Replace(' ', '_')}) {assurance})";
        }

        public string ToClipsCause(int ind = -1)
        {
            string assurance = ind == -1 ? "" : $" (assurance ?a{ind})";
            return $"(fact (id {FactID}) (name {Description.Replace(' ', '_')}){assurance})";
        }

        public string ToClipsModify()
        {
            return $"(fact (id {FactID}) (name {Description.Replace(' ', '_')}) (assurance ?a))";
        }

        public static string AssuranceMultiplyString(int count)
        {
            if (count == 1)
            {
                return "(* ?a0 1)";
            }
            else
            {
                StringBuilder assurance = new StringBuilder();
                assurance.Append("(*");
                for (int i = 0; i < count; i++)
                {
                    assurance.Append($" ?a{i}");
                }
                assurance.Append(")");
                return assurance.ToString();
            }
        }

        public string ToClipsConsequence(int count)
        {
            StringBuilder assurance = new StringBuilder("(assurance ");
            if (count > 1)
            {
                assurance.Append(AssuranceMultiplyString(count));
                assurance.Append(")");
            }
            else
            {
                assurance.Append("?a0)");
            }
            return $"(fact (id {FactID}) (name {Description.Replace(' ', '_')}){assurance})";
        }

        public string ToListItem(bool withAssurance = true)
        {
            var assurance = withAssurance?$"{string.Format("{0:0.00}", Assurance * 100)}%":"";
            return $"{FactID}. {Description.Replace("_"," ")}. {assurance}";
        }

    }
}
