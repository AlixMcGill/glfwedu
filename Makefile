CXX := g++
CXXFLAGS := -Wall -std=c++17 -Isrc -Iinclude

SRC_DIR := src
BUILD_DIR := build

# Find all .cpp and .c files
SRCS := $(shell find $(SRC_DIR) -name "*.cpp" -o -name "*.c")

# Convert source files to object files in build directory
OBJS := $(patsubst $(SRC_DIR)/%,$(BUILD_DIR)/%,$(SRCS))
OBJS := $(OBJS:.cpp=.o)
OBJS := $(OBJS:.c=.o)

TARGET := $(BUILD_DIR)/main

LIBS := -lglfw -lGL -ldl -lpthread -lwayland-client -lwayland-egl -lwayland-cursor -lxkbcommon

# Default target
all: $(TARGET)
	@echo "Build Complete!"

# Link step
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBS)

# Compile C++ files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compile C files (glad.c)
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: all
	@echo "Running $(TARGET)..."
	@$(TARGET)

# Clean build folder
clean:
	rm -rf $(BUILD_DIR)

