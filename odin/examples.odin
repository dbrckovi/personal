package examples

import "core:fmt"

main :: proc() {
	dynamic_array()
}

dynamic_array :: proc() {
	array: [dynamic]int //declare

	for x := 0; x < 10; x += 1 { 	//fill - raises cap as needed
		append(&array, x)
	}
	fmt.println("AFTER FILL Len:", len(array), "Cap:", cap(array), "Content:", array)

	delete(array) //deallocate - deallocates the memory, but variable still points to it (unsafe on it's own)
	fmt.println("AFTER DEALLOCATION Len:", len(array), "Cap:", cap(array), "Content:", array)

	array = {} //reset - just resets the array variables, memory is still there, probably leaked (unsafe on it's own)
	fmt.println("AFTER RESET Len:", len(array), "Cap:", cap(array), "Content:", array)

	for x := 0; x < 10; x += 1 { 	//fill - raises cap as needed
		append(&array, x)
	}
	fmt.println("AFTER FILL Len:", len(array), "Cap:", cap(array), "Content:", array)

	clear(&array) //clear -only clears the array. It is still allocated (safe, but can waste memory in some cases)
	fmt.println("AFTER CLEAR Len:", len(array), "Cap:", cap(array), "Content:", array)

	for x := 0; x < 10; x += 1 { 	//fill - raises cap as needed
		append(&array, x)
	}
	fmt.println("AFTER FILL Len:", len(array), "Cap:", cap(array), "Content:", array)

	unordered_remove(&array, 5) //remove one item, and put last element in it's place (fast but order is lost)
	fmt.println("AFTER UNORDERED REMOVE Len:", len(array), "Cap:", cap(array), "Content:", array)

	ordered_remove(&array, 3) //remove one item, and shift the rest to it's place (slow, but order is preserved)
	fmt.println("AFTER ORDERED REMOVE Len:", len(array), "Cap:", cap(array), "Content:", array)

	shrink(&array) //deallocates extra memory (cap becomes the same as len) - don't use without reason
	fmt.println("AFTER SHRINK Len:", len(array), "Cap:", cap(array), "Content:", array)

	//Additional
	// array2 := make([dynamic]int, 20) //pre-allocate 20 elements
	// array3 := make([dynamic]int, 20, 40) //pre-allocate 20 elements with capacity 40

}

