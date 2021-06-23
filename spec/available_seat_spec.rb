require "available_seat"
describe AvailableSeat do
  describe "Allocate seats" do
    context "when all seats are available" do
      let(:seating) { {"venue": {"layout": {"rows": 10, "columns": 50}}, "seats": { } } }
      let(:input_no_of_seats_to_allocate) { 1 }
      it "center seat from first row should assigned for single user" do
        arrangment = AvailableSeat.new(seating.to_json, input_no_of_seats_to_allocate)
        result = arrangment.number_of_available_seats
        expect(result).to eq(["Alloted seat is a25"])
      end

      it "a25 and a26 center seats from first row should assigned for multiple user" do
        arrangment = AvailableSeat.new(seating.to_json, 2)
        result = arrangment.number_of_available_seats
        expect(result).to eq(["Alloted seat is a25", "Alloted seat is a26"])
      end
    end

    context "when some seats are already taken" do
      let(:seating) { {"venue": {"layout": {"rows": 10, "columns": 12}}, "seats": { "a6": {"id": "a6", "row": "a", "column": 6, "status": "O" }, "b5": {"id": "b5", "row": "b", "column": 5, "status": "A"},"h7": {"id": "h7","row": "h","column": 7,"status": "A" } } } }
      let(:input_no_of_seats_to_allocate) { 1 }
      it "center seat is taken so from first row a7 should be assigned to user, for single user" do
        arrangment = AvailableSeat.new(seating.to_json, input_no_of_seats_to_allocate)
        result = arrangment.number_of_available_seats
        expect(result).to eq(["Alloted seat is a7"])
      end

      it "a6 is assigned, from first row a7 and a5 should be assigned to user, for multiple user" do
        arrangment = AvailableSeat.new(seating.to_json, 2)
        result = arrangment.number_of_available_seats
        expect(result).to eq(["Alloted seat is a7", "Alloted seat is a5"])
      end

      it "First row is assigned so from second row b6 should be assigned to user, for single user" do
        seating["seats"] = { "a1": {"id": "a1", "row": "a", "column": 1, "status": "O" }, "a2": {"id": "a2", "row": "a", "column": 2, "status": "O" }, "a3": {"id": "a3", "row": "a", "column": 3, "status": "O" }, "a4": {"id": "a4", "row": "a", "column": 4, "status": "O" }, "a5": {"id": "a5", "row": "a", "column": 5, "status": "O" },"a6": {"id": "a6", "row": "a", "column": 6, "status": "O" }, "a7": {"id": "a7", "row": "a", "column": 7, "status": "O" }, "a8": {"id": "a8", "row": "a", "column": 8, "status": "O" }, "a9": {"id": "a9", "row": "a", "column": 9, "status": "O" }, "a10": {"id": "a10", "row": "a", "column": 10, "status": "O" }, "a11": {"id": "a11", "row": "a", "column": 11, "status": "O" }, "a12": {"id": "a12", "row": "a", "column": 12, "status": "O" } }
        arrangment = AvailableSeat.new(seating.to_json, 1)
        result = arrangment.number_of_available_seats
        expect(result).to eq(["Alloted seat is b6"])
      end

      it "First row is assigned so from second row b6, b7, b5 should be assigned to users, for multiple user" do
        seating["seats"] = { "a1": {"id": "a1", "row": "a", "column": 1, "status": "O" }, "a2": {"id": "a2", "row": "a", "column": 2, "status": "O" }, "a3": {"id": "a3", "row": "a", "column": 3, "status": "O" }, "a4": {"id": "a4", "row": "a", "column": 4, "status": "O" }, "a5": {"id": "a5", "row": "a", "column": 5, "status": "O" },"a6": {"id": "a6", "row": "a", "column": 6, "status": "O" }, "a7": {"id": "a7", "row": "a", "column": 7, "status": "O" }, "a8": {"id": "a8", "row": "a", "column": 8, "status": "O" }, "a9": {"id": "a9", "row": "a", "column": 9, "status": "O" }, "a10": {"id": "a10", "row": "a", "column": 10, "status": "O" }, "a11": {"id": "a11", "row": "a", "column": 11, "status": "O" }, "a12": {"id": "a12", "row": "a", "column": 12, "status": "O" } }
        arrangment = AvailableSeat.new(seating.to_json, 3)
        result = arrangment.number_of_available_seats
        expect(result).to eq(["Alloted seat is b6", "Alloted seat is b7", "Alloted seat is b5"])
      end
    end
  end
end
