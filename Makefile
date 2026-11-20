PYTHON ?= python3
VENV := .venv_cmm
VENV_PYTHON := $(VENV)/bin/python
VENV_PIP := $(VENV)/bin/pip
VENV_INST := $(VENV)/.requirements-installed

SCRIPT := call_me_maybe.py
RM := rm

# CONF_FILE := maps/easy/01_linear_path.txt   # 4
# CONF_FILE := maps/easy/02_simple_fork.txt   # 4
# CONF_FILE := maps/easy/03_basic_capacity.txt    # 4
# CONF_FILE := maps/medium/01_dead_end_trap.txt   # 8
# CONF_FILE := maps/medium/02_circular_loop.txt   # 10
# CONF_FILE := maps/medium/03_priority_puzzle.txt # 6
# CONF_FILE := maps/hard/01_maze_nightmare.txt    # 13
# CONF_FILE := maps/hard/02_capacity_hell.txt     # 16
# CONF_FILE := maps/hard/03_ultimate_challenge.txt    # 26
# CONF_FILE := maps/challenger/01_the_impossible_dream.txt    # 43
# CONF_FILE := .test/test_map.txt

$(VENV_INST): requirements.txt
	$(PYTHON) -m venv $(VENV)
	$(VENV_PIP) install -r requirements.txt
	touch $(VENV_INST)


install: $(VENV_INST)

run:
	$(VENV_PYTHON) $(SCRIPT) $(CONF_FILE)

debug:
	$(VENV_PYTHON) -m pdb $(SCRIPT) $(CONF_FILE)

clean:
	$(RM) -rf __pycache__ .mypy_cache *.egg-info

fclean: clean
	$(RM) $(VENV)

lint:
	$(VENV)/bin/flake8 . --exclude $(VENV)
	$(VENV)/bin/mypy . --warn-return-any --warn-unused-ignores --ignore-missing-imports --disallow-untyped-defs --check-untyped-defs

lint-strict:
	$(VENV)/bin/flake8 . --exclude $(VENV)
	$(VENV)/bin/mypy . --strict

.PHONY: install run debug clean lint lint-strict
