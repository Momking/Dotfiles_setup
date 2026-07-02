import subprocess
from typing import Callable

from ..engines import FrameEngine
from ..states import Direction, EndByFrameAnimations
from .state_manager import State, StateManager


class AnimationTicker:
    def __init__(
        self,
        state_manager: StateManager,
        frame_engine: FrameEngine,
        upd_position: Callable[[], None],
    ):
        self.state_manager = state_manager
        self.frame_engine = frame_engine
        self.upd_position = upd_position
        self.x = 0
        self.y = 650

    def tick(self):
        # advance animation by 1 frame
        cur_state = self.state_manager.current_state
        cur_direc = self.state_manager.current_direction
        end_frame = self.frame_engine.advance(cur_state, cur_direc)

        # check for animation completion
        if end_frame and cur_state in EndByFrameAnimations:
            self.state_manager.on_completion()

        # window position update callback
        if cur_state == State.WALK:
            if cur_direc == Direction.RIGHT and self.x < 1580:
                self.x = self.x + 10  # Adjust for your screen width
                self.y = self.y  # Fixed floor height

            if cur_direc == Direction.LEFT and self.x > 0:
                self.x = self.x - 10  # Adjust for your screen width
                self.y = self.y  # Fixed floor height

            if cur_direc == Direction.UP and self.y > 0:
                self.x = self.x  # Adjust for your screen width
                self.y = self.y - 10  # Fixed floor height

            if cur_direc == Direction.DOWN and self.y < 700:
                self.x = self.x  # Adjust for your screen width
                self.y = self.y + 10  # Fixed floor height

            if cur_direc == Direction.UP_LEFT:
                if self.x > 0:
                    self.x = self.x - 10  # Adjust for your screen width
                if self.y > 0:
                    self.y = self.y - 10  # Fixed floor height

            if cur_direc == Direction.UP_RIGHT:
                if self.x < 1580:
                    self.x = self.x + 10  # Adjust for your screen width
                if self.y > 0:
                    self.y = self.y - 10  # Fixed floor height

            if cur_direc == Direction.DOWN_LEFT:
                if self.x > 0:
                    self.x = self.x - 10  # Adjust for your screen width
                if self.y < 700:
                    self.y = self.y + 10  # Fixed floor height

            if cur_direc == Direction.DOWN_RIGHT:
                if self.x < 1580:
                    self.x = self.x + 10  # Adjust for your screen width
                if self.y < 700:
                    self.y = self.y + 10  # Fixed floor height

            # 3. Tell NIRI to move the window
            # We target the window by its title
            subprocess.run(
                [
                    "niri",
                    "msg",
                    "action",
                    "move-floating-window",
                    "--x",
                    str(self.x),
                    "--y",
                    str(self.y),
                ]
            )
